//using Course_station.Models;
//using Microsoft.AspNetCore.Authorization;
//using Microsoft.AspNetCore.Identity;
//using Microsoft.AspNetCore.Mvc;
//using Microsoft.EntityFrameworkCore;
//using System.Threading.Tasks;

//namespace Course_station.Controllers
//{
//    [Authorize(Roles = "Admin")]
//    public class AdminController : Controller
//    {
//        private readonly UserManager<IdentityUser> _userManager;
//        private readonly SignInManager<IdentityUser> _signInManager;
//        private readonly ApplicationDbContext _context;

//        public AdminController(UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager, ApplicationDbContext context)
//        {
//            _userManager = userManager;
//            _signInManager = signInManager;
//            _context = context;
//        }

//        [AllowAnonymous]
//        public IActionResult AdminLogin()
//        {
//            return View();
//        }

//        [HttpPost]
//        [AllowAnonymous]
//        public async Task<IActionResult> AdminLogin(string username, string password, string indexPage)
//        {
//            var result = await _signInManager.PasswordSignInAsync(username, password, false, false);
//            if (result.Succeeded)
//            {
//                if (indexPage == "Instructor")
//                {
//                    return RedirectToAction("InstructorIndex");
//                }
//                else if (indexPage == "Learners")
//                {
//                    return RedirectToAction("LearnerIndex");
//                }
//            }

//            ModelState.AddModelError(string.Empty, "Invalid login attempt.");
//            return View();
//        }


//        public IActionResult Index()
//        {
//            return View();
//        }

//        public IActionResult InstructorIndex()
//        {
//            return RedirectToAction("Index", "Instructor");
//        }

//        public IActionResult LearnerIndex()
//        {
//            return RedirectToAction("Index", "Learners");
//        }
//    }
//}

using Course_station.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace Course_station.Controllers
{
  //  [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly ApplicationDbContext _context;

        public AdminController(UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager, ApplicationDbContext context)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _context = context;
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
                    return RedirectToAction("Index", "Instructor");
                }
                else if (indexPage == "Learners")
                {
                    return RedirectToAction("Index", "Learners");
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

