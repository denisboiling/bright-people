require 'spec_helper'

describe Question, current: true do
  it "Should be default not publish" do
    question = FactoryGirl.create(:question)
    question.publish.should == false
  end

  it "Should be publish when specialist create answer" do
    specialist = FactoryGirl.create(:specialist)
    question = FactoryGirl.create(:question, specialist: specialist )
    comment = question.comments.build(text: 'aaaaaa')
    comment.user = specialist
    comment.save
    Question.find(question).publish.should == true
  end
end
