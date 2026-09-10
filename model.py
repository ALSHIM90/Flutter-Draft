import json
import math
from pathlib import Path


MODEL_PATH = (
    Path(__file__).parent.parent
    / "models"
    / "adhd_flutter_model.json"
)


def load_adhd_model():
    with open(
        MODEL_PATH,
        "r",
        encoding="utf-8"
    ) as file:
        model = json.load(file)

    return model


def get_required_features():
    model = load_adhd_model()
    return model["feature_names"]


def sigmoid(value):
    if value >= 0:
        return 1 / (1 + math.exp(-value))

    exp_value = math.exp(value)
    return exp_value / (1 + exp_value)


def predict_adhd(features):
    model = load_adhd_model()

    feature_names = model["feature_names"]
    medians = model["imputer_medians"]
    means = model["scaler_mean"]
    scales = model["scaler_scale"]
    coefficients = model["coefficients"]
    intercept = model["intercept"]
    threshold = model["threshold"]

    logit = intercept

    for i, feature_name in enumerate(feature_names):

        value = features.get(feature_name)

        if value is None:
            value = medians[i]

        value = float(value)

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