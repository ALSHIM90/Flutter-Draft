def generate_final_result(
    percentages,
    dyslexia_result=None,
    adhd_result=None
):

    print("\n==========================================")
    print("             FINAL RESULT")
    print("==========================================\n")

    # ------------------------------------------
    # Initial assessment
    # ------------------------------------------

    print("Initial Skills Assessment:\n")

    print(
        "Reading:",
        round(percentages["reading"], 2),
        "%"
    )

    print(
        "Memory:",
        round(percentages["memory"], 2),
        "%"
    )

    print(
        "Attention:",
        round(percentages["attention"], 2),
        "%"
    )

    print("\n------------------------------------------")


    # ------------------------------------------
    # Dyslexia
    # ------------------------------------------

    if dyslexia_result is not None:

        dyslexia_probability = (
            dyslexia_result["probability"] * 100
        )

        print("\nDyslexia Screening:")

        print(
            "Probability:",
            round(dyslexia_probability, 2),
            "%"
        )

        if dyslexia_result["prediction"]:

            print(
                "Result: Screening indication detected."
            )

        else:

            print(
                "Result: No screening indication detected."
            )

    else:

        print(
            "\nDyslexia Screening: Not performed."
        )


    # ------------------------------------------
    # ADHD
    # ------------------------------------------

    if adhd_result is not None:

        adhd_probability = (
            adhd_result["probability"] * 100
        )

        print("\nADHD Screening:")

        print(
            "Probability:",
            round(adhd_probability, 2),
            "%"
        )

        if adhd_result["prediction"]:

            print(
                "Result: Screening indication detected."
            )

        else:

            print(
                "Result: No screening indication detected."
            )

    else:

        print(
            "\nADHD Screening: Not performed."
        )


    print("\n------------------------------------------")

    print(
        "\nLAMSA provides early screening indicators only."
    )

    print(
        "The result is not a medical diagnosis."
    )

    print(
        "Professional assessment is recommended "
        "when concerns are identified."
    )

    print("\n==========================================")