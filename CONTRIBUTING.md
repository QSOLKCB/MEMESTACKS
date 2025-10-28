# 🧩 Contributing to MEMESTACKS  
*“Software should behave like good hardware — lean, logical, and reliable.”*

---

## 🧠 Guiding Principle
Before writing a single line, ask:  
> “Does this make the stack faster, clearer, or smaller?”

If the answer is *no*, it doesn’t belong here.

---

## ⚙️ Development Philosophy
MEMESTACKS is part of the **QSOLKCB** ecosystem — built for clarity, performance, and simplicity.  
Every contribution should:
- Stay **minimal** — avoid dependencies unless essential.  
- Stay **transparent** — output should be visible and explainable.  
- Stay **portable** — everything must run on a fresh Arch Linux install with only coreutils + pacman.  
- Stay **readable** — no magic, no hidden logic, no needless functions.

---

## 🧰 Workflow
1. **Fork and clone**
   ```bash
   git clone https://github.com/<your-username>/MEMESTACKS.git
   cd MEMESTACKS
Create a branch

bash
Copy code
git checkout -b feature/my-improvement
Make changes

Use consistent indentation (2 spaces, no tabs).

Keep functions short and self-documenting.

Comment why, not what.

Test locally

Run both setup_dryrun.sh and setup_install.sh.

Confirm no shellcheck warnings:

bash
Copy code
shellcheck setup_*.sh
Commit cleanly

bash
Copy code
git add .
git commit -m "Add: brief, clear description"
Submit a pull request

Title should describe purpose.

Keep it under ~300 lines of diff.

Reference any related issues if applicable.

🧩 Code Style
Prefer POSIX-compliant Bash — no zsh-specific or GNU-only syntax.

Use explicit variable names (LOG_DIR, PKG_LIST, etc.).

Avoid complex inline pipes — readability beats brevity.

Log actions with simple echo "==> message" style.

Keep comments short, direct, and lowercase.

🧪 Testing Guidelines
All scripts should:

Run cleanly without user interaction where possible.

Fail gracefully with helpful output.

Leave no orphaned files or partial states.

To simulate installs:

bash
Copy code
./setup_dryrun.sh
To perform full deployment (in a safe VM or container):

bash
Copy code
./setup_install.sh
🧭 Commit Message Style
Format:

php-template
Copy code
<Type>: <Short summary>
Examples:

makefile
Copy code
Add: init logging for setup scripts
Fix: pipewire service enable bug
Docs: update README and philosophy
📄 License & Ownership
By contributing, you agree that your code will be released under the MIT License.
Attribution is preserved, and contributions remain open to community adaptation.

🧘 The QSOL Ethos
Simplicity is stability.

Clarity is performance.

Bloat is the enemy.

If your code improves clarity or efficiency — welcome aboard.

yaml
Copy code
