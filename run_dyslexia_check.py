from dyslexia_model import (
    load_dyslexia_model,
    predict_dyslexia
)


print("Starting Dyslexia test...")


model = load_dyslexia_model()

print("Model loaded successfully.")


features = {}

for i, feature_name in enumerate(
    model["feature_names"]
):
    features[feature_name] = (
        model["scaler_mean"][i]
    )


print(
    "Number of features:",
    len(features)
)


result = predict_dyslexia(
    features
)


print("\nDyslexia probability:")
print(result["probability"])

print("\nDyslexia prediction:")
print(result["prediction"])

print("\nThreshold:")
print(result["threshold"])