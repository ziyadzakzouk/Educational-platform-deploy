using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class LearnerController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly IPasswordHasher<Learner> _passwordHasher;

        public LearnerController(ApplicationDbContext context, IPasswordHasher<Learner> passwordHasher)
        {
            _context = context;
            _passwordHasher = passwordHasher;
        }

        // GET: Learner/SignUp
        public IActionResult SignUp()
        {
            return View();
        }

       //post sign up
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SignUp([Bind("FirstName,LastName,Birthday,Gender,Country,CulturalBackground,Password")] Learner learner)
        {
            if (ModelState.IsValid)
            {
                learner.Password = _passwordHasher.HashPassword(learner, learner.Password);
                _context.Add(learner);
                await _context.SaveChangesAsync();
                ViewBag.LearnerID = learner.LearnerId; // Pass the generated ID to the view
                return View("SignUpSuccess", learner);
            }
            return View(learner);
        }
        // GET: Learner/LogIn
        public IActionResult LogIn()
        {
            return View();
        }

        // POST: Learner/LogIn
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogIn(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var learner = await _context.Learners
                    .FirstOrDefaultAsync(m => m.LearnerId == model.Learner_ID);
                if (learner != null)
                {
                    var result = _passwordHasher.VerifyHashedPassword(learner, learner.Password, model.Password);
                    if (result == PasswordVerificationResult.Success)
                    {
                        // Assuming you have a method to set the user session
                        // SetUserSession(learner);
                        return RedirectToAction("Index", "Home");
                    }
                }
                ModelState.AddModelError(string.Empty, "Invalid login attempt.");
            }
            return View(model);
        }
    }
}
