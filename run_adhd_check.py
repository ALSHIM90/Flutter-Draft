from adhd_model import (
    load_adhd_model,
    predict_adhd
)


model = load_adhd_model()

features = {}

for i, feature_name in enumerate(
    model["feature_names"]
):
    features[feature_name] = (
        model["imputer_medians"][i]
    )


result = predict_adhd(features)


print("ADHD probability:")
print(result["probability"])

print()

print("ADHD prediction:")
print(result["prediction"])

print()

print("Threshold:")
print(result["threshold"])