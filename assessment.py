from questions import questions


def calculate_scores(answers, age_group):
    scores = {
        "reading": 0,
        "memory": 0,
        "attention": 0
    }

    age_questions = []

    for question in questions:
        if question["age_group"] == age_group:
            age_questions.append(question)

    for question in age_questions:
        question_id = question["id"]
        skill = question["skill"]
        correct_answer = question["answer"]

        if answers[question_id] == correct_answer:
            scores[skill] += 1

    return scores


def calculate_percentages(scores):
    percentages = {}

    for skill in scores:
        percentages[skill] = (scores[skill] / 2) * 100

    return percentages


def classify_score(percentage):
    if percentage >= 80:
        return "Strong"

    elif percentage >= 50:
        return "Needs Observation"

    else:
        return "Needs Support"


def determine_next_assessment(percentages):
    next_assessment = {
        "dyslexia": False,
        "adhd": False
    }

    if (
        percentages["reading"] < 80
        or percentages["memory"] < 80
    ):
        next_assessment["dyslexia"] = True

    if percentages["attention"] < 80:
        next_assessment["adhd"] = True

    return next_assessment