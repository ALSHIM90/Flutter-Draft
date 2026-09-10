from .model import (
    load_dyslexia_model,
    predict_dyslexia
)


def run_dyslexia_screening_test():

    print(
        "\n========== DYSLEXIA MODEL TEST =========="
    )

    model = load_dyslexia_model()

    features = {}

    for i, feature_name in enumerate(
        model["feature_names"]
    ):

        features[feature_name] = (
            model["scaler_mean"][i]
        )

    result = predict_dyslexia(
        features
    )

    probability_percent = (
        result["probability"] * 100
    )

    print(
        "Probability:",
        round(
            probability_percent,
            2
        ),
        "%"
    )

    print(
        "Threshold:",
        round(
            result["threshold"] * 100,
            2
        ),
        "%"
    )

    print(
        "Prediction:",
        result["prediction"]
    )

    print(
        "\nNOTE: This is a technical model test, "
        "not a child screening result."
    )

    return result

from .feature_builder import (
    build_dyslexia_features
)


def run_dyslexia_from_answers(
    age,
    age_group,
    answers,
    questions
):

    print(
        "\n========== DYSLEXIA SCREENING =========="
    )

    features = build_dyslexia_features(
        age=age,
        age_group=age_group,
        answers=answers,
        questions=questions
    )

    result = predict_dyslexia(
        features
    )

    probability_percent = (
        result["probability"] * 100
    )

    threshold_percent = (
        result["threshold"] * 100
    )

    print(
        "Dyslexia screening probability:",
        round(
            probability_percent,
            2
        ),
        "%"
    )

    print(
        "Model threshold:",
        round(
            threshold_percent,
            2
        ),
        "%"
    )

    if result["prediction"]:

        print(
            "Dyslexia screening indication detected."
        )

        print(
            "Further professional assessment "
            "is recommended."
        )

    else:

        print(
            "No Dyslexia screening indication "
            "was detected by the model."
        )

    print(
        "\nPrototype note:"
    )

    print(
        "This result uses the current Lamsa "
        "questions as model tasks."
    )

    return result