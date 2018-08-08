import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import 'babel-polyfill'
import ReactMarkdown from 'react-markdown'
import axios from 'axios'

class Quiz extends Component {
  constructor(props) {
    super(props);
    this.state = { questions: [], selected: null, answer: '', correct: null };

    this.postAnswer = this.postAnswer.bind(this);

    this.getQuestions();
  }

  async getQuestions() {
    const config = {
      headers: {
        "ContentType": "application/json"
      },
      responseType: "json"
    };
    let response = await axios.get('/api/questions.json', {}, config);
    const questions = response.data;
    const selected = Math.floor(Math.random() * questions.length);
    this.setState({ questions: questions, selected: selected });
  }

  async postAnswer(answer) {
    const question = this.state.questions[this.state.selected];
    const config = {
      headers: {
        "ContentType": "application/json"
      },
      responseType: "json"
    };
    let response = await axios.post(`/api/questions/${question.id}/answer.json`, { answer: answer }, config);
    this.setState({ correct: response.data.correct });
    setTimeout(() => {
      this.sampleQuestion();
    }, 5000);
  }

  sampleQuestion() {
    const questions = this.state.questions;
    this.setState({ selected: Math.floor(Math.random() * questions.length), correct: null });
  }

  render() {
    const question = this.state.questions[this.state.selected];
    if (typeof question === 'undefined') return <div/>;

    return <div className="card">
      <div className="card-header">Question</div>
      <div className="card-body">
        <ReactMarkdown source={question.content}/>
      </div>
      <div className="card-footer">
        <AnswerForm correct={this.state.correct}
                    onSubmit={this.postAnswer}/>
      </div>
    </div>
  }
}

class AnswerForm extends Component {
  constructor(props) {
    super(props);
    this.state = { answer: '' };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({ answer: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    if (this.state.answer !== '') {
      this.props.onSubmit(this.state.answer);
      this.setState({ answer: '' });
    }
  }

  inputClassName() {
    switch (this.props.correct) {
      case true:
        return 'form-control is-valid';
      case false:
        return 'form-control is-invalid';
      default:
        return 'form-control';
    }
  }

  render() {
    return <form onSubmit={this.handleSubmit}>
      <div className="input-group">
        <div className="input-group-prepend">
          <span className="input-group-text">Answer:</span>
        </div>
        <input type="text"
               className={this.inputClassName()}
               value={this.state.answer}
               readOnly={this.props.correct !== null}
               onChange={this.handleChange} />
        <AnswerFeedback correct={this.props.correct} />
      </div>
    </form>
  }
}

class AnswerFeedback extends Component {
  render() {
    switch (this.props.correct) {
      case true:
        return <div className="valid-feedback">CORRECT!</div>;
      case false:
        return <div className="invalid-feedback">INCORRECT...</div>;
      default:
        return <div/>;
    }
  }
}

document.addEventListener("DOMContentLoaded", e => {
  ReactDOM.render(<Quiz api="/api/questions.json" />, document.querySelector('.container'))
});
