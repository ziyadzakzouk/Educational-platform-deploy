const text = "Welcome to Course Station!";
const typingEffect = document.getElementById("typing-effect");

let isDeleting = false;
let charIndex = 0;

function type() {
    const currentText = text.slice(0, charIndex);
    typingEffect.textContent = currentText;

    if (isDeleting) {
        charIndex--;
        if (charIndex === 0) {
            isDeleting = false;
        }
    } else {
        charIndex++;
        if (charIndex === text.length) {
            isDeleting = true;
        }
    }

    setTimeout(type, isDeleting ? 50 : 100); // Speed up when deleting
}

type();
