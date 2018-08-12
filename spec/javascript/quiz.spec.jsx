import React from 'react'
import { shallow, mount, render } from 'enzyme'
import { Quiz, AnswerForm, AnswerFeedback } from 'packs/quiz'

describe('<Quiz />', () => {
  test('Initial states', () => {
    const wrapper = shallow(<Quiz />);
    const questions = [
      { id: 1, content: 'How many letters are there in the English alphabet?' }
    ];

    wrapper.setState({ questions: questions, selected: 0 });
    expect(wrapper.find(AnswerForm).length).toBe(1);
  });
});

describe('<AnswerForm />', () => {
  test('When answer is correct', () => {
    const wrapper = mount(<AnswerForm />);

    wrapper.setProps({ correct: true });
    expect(wrapper.find(AnswerFeedback).length).toBe(1);
    expect(wrapper.find('.valid-feedback').length).toBe(1);
  });

  test('When answer is incorrect', () => {
    const wrapper = mount(<AnswerForm />);

    wrapper.setProps({ correct: false });
    expect(wrapper.find(AnswerFeedback).length).toBe(1);
    expect(wrapper.find('.invalid-feedback').length).toBe(1);
  })
});
