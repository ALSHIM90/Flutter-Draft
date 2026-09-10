from .model import load_adhd_model


FEATURE_LABELS = {
    "APQ_P_APQ_P_CP":
        "Corporal Punishment Score",

    "APQ_P_APQ_P_ID":
        "Inconsistent Discipline Score",

    "APQ_P_APQ_P_INV":
        "Involvement Score",

    "APQ_P_APQ_P_OPD":
        "Other Discipline Practices Score",

    "APQ_P_APQ_P_PM":
        "Poor Monitoring / Supervision Score",

    "APQ_P_APQ_P_PP":
        "Positive Parenting Score",

    "SDQ_SDQ_Conduct_Problems":
        "Conduct Problems Score",

    "SDQ_SDQ_Difficulties_Total":
        "Total Difficulties Score",

    "SDQ_SDQ_Emotional_Problems":
        "Emotional Problems Score",

    "SDQ_SDQ_Externalizing":
        "Externalizing Score",

    "SDQ_SDQ_Generating_Impact":
        "Generating Impact Score",

    "SDQ_SDQ_Hyperactivity":
        "Hyperactivity Score",

    "SDQ_SDQ_Internalizing":
        "Internalizing Score",

    "SDQ_SDQ_Peer_Problems":
        "Peer Problems Score",

    "SDQ_SDQ_Prosocial":
        "Prosocial Score"
}


def build_adhd_features(score_inputs):

    model = load_adhd_model()

    feature_names = model["feature_names"]
    medians = model["imputer_medians"]

    features = {}

    for i, feature_name in enumerate(
        feature_names
    ):

        if feature_name in score_inputs:

            features[feature_name] = (
                score_inputs[feature_name]
            )

        else:

            # Missing score → use training median
            features[feature_name] = (
                medians[i]
            )

    return features