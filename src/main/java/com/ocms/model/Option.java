package com.ocms.model;

/**
 * Option Entity POJO.
 */
public class Option {
    private int optionId;
    private int questionId;
    private String optionText;
    private boolean correct;
    private int orderIndex;

    public Option() {
    }

    public Option(int optionId, int questionId, String optionText, boolean correct, int orderIndex) {
        this.optionId = optionId;
        this.questionId = questionId;
        this.optionText = optionText;
        this.correct = correct;
        this.orderIndex = orderIndex;
    }

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getOptionText() {
        return optionText;
    }

    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public boolean isCorrect() {
        return correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }

    public int getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(int orderIndex) {
        this.orderIndex = orderIndex;
    }
}
