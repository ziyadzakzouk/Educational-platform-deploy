using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Course_station.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly SignInManager<IdentityUser> _signInManager;

        public AdminController(SignInManager<IdentityUser> signInManager)
        {
            _signInManager = signInManager;
        }

        [AllowAnonymous]
        public IActionResult AdminLogin()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> AdminLogin(string username, string password, string indexPage)
        {
            var result = await _signInManager.PasswordSignInAsync(username, password, false, false);
            if (result.Succeeded)
            {
                if (indexPage == "Instructor")
                {
                    return RedirectToAction("InstructorIndex");
                }
                else if (indexPage == "Learners")
                {
                    return RedirectToAction("LearnerIndex");
                }
            }

            ModelState.AddModelError(string.Empty, "Invalid login attempt.");
            return View();
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult InstructorIndex()
        {
            return RedirectToAction("Index", "Instructor");
        }

        public IActionResult LearnerIndex()
        {
            return RedirectToAction("Index", "Learners");
        }
    }
}
