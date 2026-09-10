from .model import (
    predict_adhd
)

from .feature_builder import (
    FEATURE_LABELS,
    build_adhd_features
)


def collect_adhd_scores():

    print(
        "\n=========================================="
    )

    print(
        "          ADHD DEEP SCREENING"
    )

    print(
        "==========================================\n"
    )

    print(
        "Enter the questionnaire scale scores."
    )

    print(
        "These are APQ / SDQ scores, "
        "not the initial Lamsa questions.\n"
    )

    scores = {}

    for feature_name, label in (
        FEATURE_LABELS.items()
    ):

        while True:

            value = input(
                f"{label}: "
            ).strip()

            # Empty input = missing value
            if value == "":

                scores[
                    feature_name
                ] = None

                break

            try:

                scores[
                    feature_name
                ] = float(
                    value
                )

                break

            except ValueError:

                print(
                    "Please enter a number "
                    "or press Enter if missing."
                )

    return scores


def run_adhd_screening():

    score_inputs = (
        collect_adhd_scores()
    )

    features = build_adhd_features(
        score_inputs
    )

    result = predict_adhd(
        features
    )

    probability_percent = (
        result["probability"]
        * 100
    )

    threshold_percent = (
        result["threshold"]
        * 100
    )

    print(
        "\n=========================================="
    )

    print(
        "           ADHD MODEL RESULT"
    )

    print(
        "=========================================="
    )

    print(
        "Screening probability:",
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
            "\nADHD screening indication detected."
        )

        print(
            "Further professional assessment "
            "is recommended."
        )

    else:

        print(
            "\nNo ADHD screening indication "
            "was detected by the model."
        )

    print(
        "\nThis is a screening result, "
        "not a medical diagnosis."
    )

    return result