import React from 'react'
import renderer from 'react-test-renderer'
import { shallow, mount, render } from 'enzyme'
import { Quiz, AnswerForm, AnswerFeedback } from 'packs/quiz'

describe('<Quiz />', () => {
  const questions = [
    { id: 1, content: 'How many letters are there in the English alphabet?' }
  ];

  test('Initial states', () => {
    const wrapper = shallow(<Quiz />);

    wrapper.setState({ questions: questions, selected: 0 });
    expect(wrapper.find(AnswerForm).length).toBe(1);
    expect(wrapper.find(AnswerFeedback).length).toBe(0);
  });

  test('', () => {

  })
});
