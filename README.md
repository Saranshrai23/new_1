<p align="center">
  <img width="600" height="300" alt="Git Flow" src="https://git-scm.com/images/logos/downloads/Git-Logo-2Color.png" />
  <br/>
</p>

<h1 align="center">Common Stack | Others | Git Flow | SOP for Git Flow</h1>

<p align="center">
  Step by step workflow guide
</p>

---

## Author Table

| Author    | Created on | Version | Last updated by | Last Edited On | L0 Reviewer | L1 Reviewer | L2 Reviewer |
| --------- | ---------- | ------- | --------------- | -------------- | ----------- | ----------- | ----------- |
| Your Name | 24-04-2026 | 1.0     | Your Name       | 24-04-2026     | -           | -           | -           |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [What is Git Flow](#2-what-is-git-flow)
3. [Why Git Flow](#3-why-git-flow)
4. [Workflow](#4-workflow)
5. [Workflow Diagram](#5-workflow-diagram)
6. [Advantages](#6-advantages)
7. [Disadvantages](#7-disadvantages)
8. [Conclusion](#8-conclusion)
9. [Contact Information](#9-contact-information)
10. [References](#10-references)

---

## 1. Introduction

Git Flow is a branching strategy used with Git to manage code in a structured way.

It helps teams organize development, releases, and production fixes using separate branches.

---

## 2. What is Git Flow

Git Flow is a workflow model that defines how branches should be created, used, and merged.

It mainly uses:

* `main` / `master` for production-ready code
* `develop` for active development
* `feature/*` for new features
* `release/*` for release preparation
* `hotfix/*` for urgent production fixes

---

## 3. Why Git Flow

Git Flow is used to keep development and production code separate.

It helps teams manage releases safely and fix production issues quickly.

### Key Reasons

* Clear branch structure
* Stable production code
* Easy release management
* Better team collaboration
* Quick hotfix handling

---

## 4. Workflow

### Main Branches

| Branch            | Purpose                 |
| ----------------- | ----------------------- |
| `main` / `master` | Production-ready code   |
| `develop`         | Latest development code |

### Supporting Branches

| Branch Type | Created From | Merged Into       | Purpose             |
| ----------- | ------------ | ----------------- | ------------------- |
| `feature/*` | `develop`    | `develop`         | New feature work    |
| `release/*` | `develop`    | `main`, `develop` | Release preparation |
| `hotfix/*`  | `main`       | `main`, `develop` | Production bug fix  |

### Basic Commands Example

Create a feature branch:

```bash
git checkout develop
git checkout -b feature/login-page
```

Merge feature into develop:

```bash
git checkout develop
git merge feature/login-page
```

Create a release branch:

```bash
git checkout develop
git checkout -b release/v1.0.0
```

Create a hotfix branch:

```bash
git checkout main
git checkout -b hotfix/fix-login-bug
```

---

## 5. Workflow Diagram

```text
feature/*  ───────► develop ───────► release/* ───────► main
                                  │                    │
                                  └──── merge back ◄────┘

hotfix/*   ◄────── main ───────► main + develop
```

### Simple Flow

```text
Feature → Develop → Release → Main
Bug in Main → Hotfix → Main + Develop
```

---

## 6. Advantages

| Advantage            | Description                                   |
| -------------------- | --------------------------------------------- |
| Structured workflow  | Clear branching model                         |
| Stable production    | `main` contains stable code                   |
| Parallel development | Multiple features can be developed together   |
| Easy releases        | Release branches help testing and preparation |
| Hotfix support       | Production bugs can be fixed quickly          |

---

## 7. Disadvantages

| Disadvantage          | Description                         |
| --------------------- | ----------------------------------- |
| Complex for beginners | More branches to understand         |
| Extra overhead        | May be too much for small projects  |
| Merge conflicts       | Long branches can cause conflicts   |
| Slower for CI/CD      | Not ideal for very fast deployments |

---

## 8. Conclusion

Git Flow is useful for teams that need planned releases and stable production code.

It gives a clear process for feature development, release preparation, and hotfixes.

For small projects, a simpler workflow may be enough.

---

## 9. Contact Information

Your Name

---

## 10. References

| Resource                 | Link                                                                                                                                                         |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Git Documentation        | [https://git-scm.com/docs](https://git-scm.com/docs)                                                                                                         |
| Git Flow Original Model  | [https://nvie.com/posts/a-successful-git-branching-model/](https://nvie.com/posts/a-successful-git-branching-model/)                                         |
| Atlassian Git Flow Guide | [https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) |
