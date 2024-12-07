using Course_station.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Diagnostics;
using System.Security.Claims;

namespace Course_station.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        // GET: AdminLogin
        public IActionResult AdminLogin()
        {
            return View();
        }

        // POST: AdminLogin
        [HttpPost]
        public async Task<IActionResult> AdminLogin(string username, string password, string indexPage)
        {
            if (username == "youssef.ashraf" && password == "20052099404Xx")
            {
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, username)
                };

                var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));

                // Redirect to the selected index page
                if (indexPage == "Instructor")
                {
                    return RedirectToAction("Index", "Instructor");
                }
                else if (indexPage == "Learners")
                {
                    return RedirectToAction("Index", "Learners");
                }
                // else if (indexPage == "Courses") or it can be Assessment or quests or others modify here
            }
            return RedirectToAction("Index", "Home");
        }

        [Authorize]
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [Authorize]
        [HttpPost]
        public IActionResult Delete(int id)
        {
            // Add your delete logic here
            return RedirectToAction("Index");
        }

        public IActionResult Details(int id)
        {
            // Add your details logic here
            return View();
        }

        public IActionResult Create()
        {
            // Add your create logic here
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
