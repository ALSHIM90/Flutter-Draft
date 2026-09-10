import json
import math
from pathlib import Path


MODEL_PATH = (
    Path(__file__).parent.parent
    / "models"
    / "dyslexia_flutter_model.json"
)


def load_dyslexia_model():

    with open(
        MODEL_PATH,
        "r",
        encoding="utf-8"
    ) as file:

        model = json.load(file)

    return model


def get_required_features():

    model = load_dyslexia_model()

    return model["feature_names"]


def sigmoid(value):

    if value >= 0:
        return 1 / (
            1 + math.exp(-value)
        )

    exp_value = math.exp(value)

    return exp_value / (
        1 + exp_value
    )


def predict_dyslexia(features):

    model = load_dyslexia_model()

    feature_names = model["feature_names"]
    means = model["scaler_mean"]
    scales = model["scaler_scale"]
    coefficients = model["coefficients"]
    intercept = model["intercept"]
    threshold = model["threshold"]

    missing_features = [
        name
        for name in feature_names
        if name not in features
    ]

    if missing_features:
        raise ValueError(
            "Missing Dyslexia features: "
            + ", ".join(missing_features)
        )

    logit = intercept

    for i, feature_name in enumerate(
        feature_names
    ):

        value = float(
            features[feature_name]
        )

        if scales[i] == 0:
            scaled_value = 0

        else:
            scaled_value = (
                value - means[i]
            ) / scales[i]

        logit += (
            scaled_value
            * coefficients[i]
        )

    probability = sigmoid(logit)

    prediction = (
        probability >= threshold
    )

    return {
        "probability": probability,
        "prediction": prediction,
        "threshold": threshold
    }