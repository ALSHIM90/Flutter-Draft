from .model import load_dyslexia_model


def build_dyslexia_features(
    age,
    age_group,
    answers,
    questions
):
    model = load_dyslexia_model()

    feature_names = model["feature_names"]
    means = model["scaler_mean"]

    # -----------------------------------------
    # 1. Start with training means
    # -----------------------------------------

    features = {}

    for i, feature_name in enumerate(
        feature_names
    ):
        features[feature_name] = means[i]

    # -----------------------------------------
    # 2. Add child age if model uses Age
    # -----------------------------------------

    if "Age" in features:
        features["Age"] = float(age)

    # -----------------------------------------
    # 3. Get questions for selected age group
    # -----------------------------------------

    age_questions = [
        question
        for question in questions
        if question["age_group"] == age_group
    ]

    # -----------------------------------------
    # 4. Convert each question into task data
    # -----------------------------------------

    for task_number, question in enumerate(
        age_questions,
        start=1
    ):

        question_id = question["id"]

        user_answer = answers[
            question_id
        ]

        correct_answer = question[
            "answer"
        ]

        clicks = 1

        if user_answer == correct_answer:
            hits = 1
            misses = 0
            score = 1

        else:
            hits = 0
            misses = 1
            score = 0

        accuracy = hits / clicks
        missrate = misses / clicks

        # -------------------------------------
        # Feature names expected by model
        # -------------------------------------

        task_values = {
            f"Clicks{task_number}":
                clicks,

            f"Hits{task_number}":
                hits,

            f"Misses{task_number}":
                misses,

            f"Score{task_number}":
                score,

            f"Accuracy{task_number}":
                accuracy,

            f"Missrate{task_number}":
                missrate
        }

        # Only update features that actually
        # exist in the trained model
        for name, value in (
            task_values.items()
        ):

            if name in features:
                features[name] = value

    return features
