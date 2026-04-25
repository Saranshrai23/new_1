<p align="center">
  <img width="600" height="300" alt="Git Flow" src="https://git-scm.com/images/logos/downloads/Git-Logo-2Color.png" />
  <br/>
</p>

<h1 align="center">Commit Hooks Recommendation</h1>

<p align="center">
  Step by step workflow guide
</p>

---

## Author Table

| **Author**  | **Created on** | **Version** | **Last updated by** | **Last edited on** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ----------- | -------------- | ----------- | ------------------- | ------------------ | --------------- | --------------- | --------------- |
| Saransh Rai | 25-04-2026     | v1.0        | Saransh Rai         | 25-04-2026         | Anuj Jain       | Prashant Sharma | Piyush Upadhyay |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Purpose of Commit Hooks](#2-purpose-of-commit-hooks)
3. [Types of Git Hooks](#3-types-of-git-hooks)
4. [Recommended Hooks](#4-recommended-hooks)

   * 4.1 [Linting](#41-linting)
   * 4.2 [Formatting](#42-formatting)
   * 4.3 [Tests](#43-tests)
   * 4.4 [Security & Secrets](#44-security--secrets)
   * 4.5 [Commit Messages](#45-commit-messages)
5. [Tools for Managing Hooks](#5-tools-for-managing-hooks)
6. [Advantages and Disadvantages](#6-advantages-and-disadvantages)
7. [Best Practices](#7-best-practices)
8. [Conclusion](#8-conclusion)
9. [Contact Information](#9-contact-information)
10. [References](#10-references)

---

## 1. Introduction

Commit hooks, also known as Git hooks, are scripts that run automatically at specific points in the Git workflow. For example, a hook can run before a commit is created, before code is pushed, or after a merge is completed.

These hooks help teams catch issues early by checking code quality, formatting, test cases, secrets, and commit message standards before the code reaches the remote repository.

This document provides structured recommendations for implementing commit hooks for linting, formatting, testing, security scanning, and commit message validation.

---

## 2. Purpose of Commit Hooks

The main purpose of commit hooks is to automate important checks in the development workflow.

| **Purpose**                  | **Explanation**                                                                             |
| ---------------------------- | ------------------------------------------------------------------------------------------- |
| Catch issues early           | Hooks help detect linting, formatting, or test failures before code is committed or pushed. |
| Enforce standards            | Teams can maintain consistent coding style and commit message format.                       |
| Prevent sensitive data leaks | Hooks can block commits that contain secrets, passwords, tokens, or credentials.            |
| Maintain branch stability    | Pre-push hooks can run tests before code reaches the remote branch.                         |
| Automate team rules          | Team policies can be converted into automated checks.                                       |

---

## 3. Types of Git Hooks

| **Git Hook** | **When It Runs**                                             | **Common Use Case**                     |
| ------------ | ------------------------------------------------------------ | --------------------------------------- |
| pre-commit   | Before a commit is created                                   | Linting, formatting, secret scanning    |
| commit-msg   | After entering commit message but before commit is finalized | Commit message validation               |
| pre-push     | Before pushing code to remote repository                     | Running unit tests or integration tests |
| post-commit  | After a commit is created                                    | Notifications or local automation       |
| post-merge   | After merging branches                                       | Dependency updates or cleanup tasks     |

**Recommendation:** Start with `pre-commit` for linting, formatting, and secret scanning. Then add `commit-msg` for commit message rules. Use `pre-push` for tests if required.

---

## 4. Recommended Hooks

### 4.1 Linting

Linting checks code for syntax errors, style issues, and possible bugs.

| **Recommendation**            | **Explanation**                                                                |
| ----------------------------- | ------------------------------------------------------------------------------ |
| Use language-specific linters | Examples include ESLint for JavaScript, Ruff for Python, and RuboCop for Ruby. |
| Fail on major errors          | The commit should fail if serious linting issues are found.                    |
| Share linting config in repo  | This ensures every developer follows the same rules.                           |

---

### 4.2 Formatting

Formatting hooks help maintain consistent code style automatically.

| **Recommendation**       | **Explanation**                                                         |
| ------------------------ | ----------------------------------------------------------------------- |
| Use formatters           | Examples include Prettier, Black, and gofmt.                            |
| Auto-format staged files | The hook can format only the files being committed.                     |
| Re-stage formatted files | After formatting, the updated files should be added back to the commit. |
| Enforce formatting in CI | CI should also check formatting so hooks are not the only control.      |

---

### 4.3 Tests

Testing hooks help verify that code changes do not break existing functionality.

| **Recommendation**           | **Explanation**                                                     |
| ---------------------------- | ------------------------------------------------------------------- |
| Run fast tests before commit | Small unit tests can run during pre-commit.                         |
| Run full tests before push   | Larger test suites are better suited for pre-push.                  |
| Run affected tests only      | This improves speed by running tests related to changed files only. |

---

### 4.4 Security & Secrets

Security hooks help prevent accidental leakage of sensitive information.

| **Recommendation**            | **Explanation**                                                     |
| ----------------------------- | ------------------------------------------------------------------- |
| Use secret scanning tools     | Examples include detect-secrets, gitleaks, and truffleHog.          |
| Block high-confidence matches | Commits should fail if real secrets are detected.                   |
| Maintain allowlists           | Safe patterns can be added to allowlists to reduce false positives. |

---

### 4.5 Commit Messages

Commit message hooks help maintain clean and meaningful commit history.

| **Recommendation**          | **Explanation**                                             |
| --------------------------- | ----------------------------------------------------------- |
| Follow Conventional Commits | Example: `feat(auth): add login functionality`.             |
| Limit subject length        | A good commit subject is usually between 50–72 characters.  |
| Avoid unclear messages      | Messages like `WIP`, `fix`, or `changes` should be avoided. |

---

## 5. Tools for Managing Hooks

| **Tool**         | **Description**                                        | **Best For**                       |
| ---------------- | ------------------------------------------------------ | ---------------------------------- |
| pre-commit       | Multi-language hook framework using YAML configuration | Python, multi-language projects    |
| Husky            | Git hook manager popular in Node.js projects           | JavaScript and Node.js projects    |
| lint-staged      | Runs checks only on staged files                       | Faster linting and formatting      |
| Lefthook         | Fast hook manager with YAML configuration              | Teams needing speed and simplicity |
| Native Git hooks | Default Git hook scripts inside `.git/hooks`           | Simple local-only use cases        |

**Recommendation:** Use `pre-commit` or `Lefthook` for version-controlled hook configuration. For Node.js projects, `Husky` with `lint-staged` is also a good option.

---

## 6. Advantages and Disadvantages

### Advantages

| **Advantage**                   | **Explanation**                                                                    |
| ------------------------------- | ---------------------------------------------------------------------------------- |
| Consistent code quality         | Hooks ensure all developers follow the same quality checks before committing code. |
| Faster local feedback           | Developers get errors immediately instead of waiting for CI/CD failure.            |
| Improved security               | Secret scanning hooks reduce the chance of pushing credentials or tokens.          |
| Better team discipline          | Commit message and formatting rules help maintain clean project history.           |
| Automation of repetitive checks | Manual checks like linting and formatting can be automated.                        |

### Disadvantages

| **Disadvantage**             | **Explanation**                                                                    |
| ---------------------------- | ---------------------------------------------------------------------------------- |
| Hooks can be bypassed        | Developers can skip hooks using `--no-verify`.                                     |
| Slow commits                 | Heavy checks can make commits slower and frustrate developers.                     |
| Setup overhead               | Teams need to configure and maintain hook tools.                                   |
| False positives              | Secret scanners or linters may sometimes block safe code.                          |
| Local environment dependency | Hooks may behave differently if developers have different tool versions installed. |

---

## 7. Best Practices

| **Best Practice**                 | **Explanation**                                                             |
| --------------------------------- | --------------------------------------------------------------------------- |
| Keep pre-commit hooks lightweight | Heavy checks should be moved to pre-push or CI/CD.                          |
| Version-control hook configs      | Store hook configuration in the repository so everyone uses the same setup. |
| Align hooks with CI/CD            | CI/CD should repeat important checks because hooks can be skipped.          |
| Document skip policy              | Clearly mention when `--no-verify` can be used.                             |
| Provide onboarding steps          | New developers should know how to install and use hooks.                    |
| Review hook changes               | Treat hook configuration changes like normal code changes.                  |

---

## 8. Conclusion

Commit hooks are a practical way to improve code quality, security, formatting, testing, and commit message standards before code reaches the remote repository.

**Final Recommendations:**

| **Area**        | **Recommended Hook** | **Recommended Tool**                 |
| --------------- | -------------------- | ------------------------------------ |
| Linting         | pre-commit           | pre-commit, ESLint, Ruff             |
| Formatting      | pre-commit           | Prettier, Black, gofmt               |
| Secret scanning | pre-commit           | detect-secrets, gitleaks, truffleHog |
| Commit messages | commit-msg           | commitlint, Conventional Commits     |
| Tests           | pre-push             | pytest, npm test, Maven test         |

---

## 9. Contact Information

| **Name**    | **Email**                                                                       |
| ----------- | ------------------------------------------------------------------------------- |
| Saransh Rai | [saransh.rai.snaatak@mygurukulam.co](mailto:saransh.rai.snaatak@mygurukulam.co) |

---

## 10. References

* [Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
* [pre-commit](https://pre-commit.com/)
* [Conventional Commits](https://www.conventionalcommits.org/)
* [Husky](https://typicode.github.io/husky/)
* [Lefthook](https://github.com/evilmartians/lefthook)
* [detect-secrets](https://github.com/Yelp/detect-secrets)

