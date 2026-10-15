from flask import Flask, render_template, request
import joblib
import os
app = Flask(__name__)
model = joblib.load("model.joblib")
def get_model_version():
    return os.environ.get("MODEL_VERSION", "1.0")
@app.route("/", methods=["GET", "POST"])
def index():
    prediction = None
    error = None
    if request.method == "POST":
        try:
            hours = float(request.form["hours"])
            attendance = float(request.form["attendance"])
            marks = float(request.form["marks"])

            if not 0 <= hours <= 24:
                raise ValueError()

            if not 0 <= attendance <= 100:
                raise ValueError()

            if not 0 <= marks <= 50:
                raise ValueError()

            result = model.predict(
                [[hours, attendance, marks]]
            )[0]
            prediction = "Pass" if result == 1 else "Fail"
        except (ValueError, KeyError):
            error = "Please enter valid values within the allowed ranges."
    return render_template(
        "index.html",
        prediction=prediction,
        error=error,
        model_version=get_model_version()
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
