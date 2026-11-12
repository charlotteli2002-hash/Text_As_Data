from pathlib import Path
import json

import numpy as np

from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, classification_report, roc_auc_score

from sklearn.feature_extraction.text import TfidfVectorizer

DATA_DIR = Path("data")

with open(DATA_DIR / "train_core_vs_neg.json", "r", encoding="utf-8") as f:
    train_data = json.load(f)

with open(DATA_DIR / "test_core_vs_neg.json", "r", encoding="utf-8") as f:
    test_data = json.load(f)

X_train_texts = [t for (t, y) in train_data]
y_train = [y for (t, y) in train_data]

X_test_texts = [t for (t, y) in test_data]
y_test = [y for (t, y) in test_data]

vectorizer = TfidfVectorizer(lowercase=True, min_df=5, max_df=0.9)

X_train = vectorizer.fit_transform(X_train_texts)
X_test = vectorizer.transform(X_test_texts)

clf = LogisticRegression(l1_ratio=1, solver="liblinear", max_iter=2000)

clf.fit(X_train, y_train)


y_pred = clf.predict(X_test)
y_prob = clf.predict_proba(X_test)[:, 1]

cm = confusion_matrix(y_test, y_pred)
print("Confusion matrix:")
print(cm)

print("\nClassification report:")
print(classification_report(y_test, y_pred))

auc = roc_auc_score(y_test, y_prob)
print("ROC AUC:", round(auc, 3))

n_nonzero = np.count_nonzero(clf.coef_[0])
n_total = clf.coef_.shape[1]
print(
    f"\nSparsity diagnostic: {n_nonzero} of {n_total} coefficients are non-zero "
    f"({n_nonzero / n_total:.1%} non-zero, {1 - n_nonzero / n_total:.1%} zero)"
)

# Top-weighted words
TOP_K = 15
feature_names = vectorizer.get_feature_names_out()
coefs = clf.coef_[0]
order = np.argsort(coefs)

print(f"\nTop {TOP_K} positive-weight words (most predictive of CORE = 1):")
for i in [i for i in order[::-1] if coefs[i] > 0][:TOP_K]:
    print(f"  {feature_names[i]:<20} {coefs[i]:+.4f}")

print(f"\nTop {TOP_K} negative-weight words (most predictive of NEG = 0):")
for i in [i for i in order if coefs[i] < 0][:TOP_K]:
    print(f"  {feature_names[i]:<20} {coefs[i]:+.4f}")

# 10 false negatives
import sys

sys.stdout.reconfigure(encoding="utf-8")  # old texts have special characters
fn_idx = [i for i in range(len(y_test)) if y_test[i] == 1 and y_pred[i] == 0]

print(f"\nFalse negatives (true CORE, predicted NEG): {len(fn_idx)} total, showing 10")
for i in fn_idx[:10]:
    print(f"\n[FN] index={i}  P(core)={y_prob[i]:.3f}")
    print(X_test_texts[i])
