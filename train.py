import numpy as np
import joblib
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
# Generate sample student data
np.random.seed(42)
n = 1000
study_hours = np.random.uniform(0, 10, n)
attendance = np.random.uniform(30, 100, n)
internal_marks = np.random.uniform(0, 50, n)
X = np.column_stack([
    study_hours,
    attendance,
    internal_marks
])
# Generate sample Pass/Fail labels
score = (
    study_hours * 2
    + attendance * 0.08
    + internal_marks * 0.8
)
y = (score >= 50).astype(int)
# Train the ML model
model = make_pipeline(
    StandardScaler(),
    LogisticRegression(random_state=42, max_iter=1000)
)
model.fit(X, y)
# Save the trained model
joblib.dump(model, "model.joblib")
print("Model trained successfully!")
