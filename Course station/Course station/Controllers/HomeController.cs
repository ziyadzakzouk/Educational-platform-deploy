using Course_station.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

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
        public IActionResult AdminLogin(string username, string password, string indexPage)
        {
            if (username == "youssef.ashraf" && password == "20052099404Xx")
            {
                // Redirect to the selected index page
                if (indexPage == "Instructor")
                {
                    return RedirectToAction("Index", "Instructor");
                }
                else if (indexPage == "Learners")
                {
                    return RedirectToAction("Index", "Learners");
                }
                // and the rest for the quest and course and Assessment or other
                
                    return RedirectToAction("Index", "Home");
                
            }
            else
            {
                // Invalid login attempt
                ViewBag.ErrorMessage = "Invalid username or password";
                return View();
            }
        }
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
