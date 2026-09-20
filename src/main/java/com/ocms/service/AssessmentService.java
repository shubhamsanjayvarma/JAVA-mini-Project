package com.ocms.service;

import com.ocms.dao.AssessmentDAO;
import com.ocms.dao.AttemptDAO;
import com.ocms.dao.QuestionDAO;
import com.ocms.model.Assessment;
import com.ocms.model.Attempt;
import com.ocms.model.AttemptAnswer;
import com.ocms.model.Option;
import com.ocms.model.Question;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 * Service managing Assessments, Multiple Choice Questions, and Attempt Evaluation.
 */
public class AssessmentService {

    private static final Logger LOGGER = Logger.getLogger(AssessmentService.class.getName());
    private final AssessmentDAO assessmentDAO;
    private final QuestionDAO questionDAO;
    private final AttemptDAO attemptDAO;

    public AssessmentService() {
        this.assessmentDAO = new AssessmentDAO();
        this.questionDAO = new QuestionDAO();
        this.attemptDAO = new AttemptDAO();
    }

    public List<Assessment> getAssessmentsByCourse(int courseId) {
        return assessmentDAO.findByCourseId(courseId);
    }

    public List<Assessment> getAssessmentsByInstructor(int instructorId) {
        return assessmentDAO.findByInstructorId(instructorId);
    }

    public Assessment getAssessmentById(int assessmentId) {
        Assessment a = assessmentDAO.findById(assessmentId);
        if (a != null) {
            a.setQuestions(questionDAO.findByAssessmentId(assessmentId));
        }
        return a;
    }

    public boolean createAssessment(Assessment assessment) {
        return assessmentDAO.create(assessment);
    }

    public boolean updateAssessment(Assessment assessment) {
        return assessmentDAO.update(assessment);
    }

    public boolean deleteAssessment(int assessmentId) {
        return assessmentDAO.delete(assessmentId);
    }

    public boolean addQuestion(Question question, List<Option> options) {
        return questionDAO.createQuestionWithOptions(question, options);
    }

    public boolean deleteQuestion(int questionId) {
        return questionDAO.delete(questionId);
    }

    /**
     * Evaluates and records a student assessment submission.
     * Computes score, percentage, and pass/fail based on database option correctness.
     *
     * @param assessmentId           assessment being taken
     * @param userId                 student taking assessment
     * @param enrollmentId           student's course enrollment id
     * @param questionSelectedOption Map of questionId -> selected optionId
     * @return saved Attempt entity or null if failure
     */
    public Attempt submitAssessment(int assessmentId, int userId, int enrollmentId,
                                    Map<Integer, Integer> questionSelectedOption) {
        Assessment assessment = getAssessmentById(assessmentId);
        if (assessment == null || assessment.getQuestions().isEmpty()) {
            LOGGER.warning("Assessment not found or has no questions: " + assessmentId);
            return null;
        }

        int score = 0;
        int totalMarks = 0;
        List<AttemptAnswer> answers = new ArrayList<>();

        for (Question q : assessment.getQuestions()) {
            totalMarks += q.getMarks();
            Integer selectedOptId = questionSelectedOption.get(q.getQuestionId());
            boolean isCorrect = false;

            if (selectedOptId != null) {
                for (Option opt : q.getOptions()) {
                    if (opt.getOptionId() == selectedOptId && opt.isCorrect()) {
                        isCorrect = true;
                        score += q.getMarks();
                        break;
                    }
                }
            }

            AttemptAnswer ans = new AttemptAnswer();
            ans.setQuestionId(q.getQuestionId());
            ans.setSelectedOptionId(selectedOptId != null ? selectedOptId : 0);
            ans.setCorrect(isCorrect);
            answers.add(ans);
        }

        BigDecimal percentage = BigDecimal.ZERO;
        if (totalMarks > 0) {
            percentage = BigDecimal.valueOf((score * 100.0) / totalMarks)
                    .setScale(2, RoundingMode.HALF_UP);
        }

        boolean passed = score >= assessment.getPassingScore();

        Attempt attempt = new Attempt();
        attempt.setAssessmentId(assessmentId);
        attempt.setUserId(userId);
        attempt.setEnrollmentId(enrollmentId);
        attempt.setScore(score);
        attempt.setTotalScore(totalMarks);
        attempt.setPercentage(percentage);
        attempt.setPassed(passed);

        boolean saved = attemptDAO.saveAttempt(attempt, answers);
        if (saved) {
            LOGGER.info("Assessment " + assessmentId + " submitted by user " + userId
                    + ": score=" + score + "/" + totalMarks + " (" + percentage + "%), passed=" + passed);
            return attempt;
        }
        return null;
    }

    public List<Attempt> getStudentAttempts(int userId) {
        return attemptDAO.findByUserId(userId);
    }

    public List<Attempt> getAssessmentAttempts(int assessmentId) {
        return attemptDAO.findByAssessmentId(assessmentId);
    }

    public Attempt getAttemptDetails(int attemptId) {
        return attemptDAO.findById(attemptId);
    }
}
