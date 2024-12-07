using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Course_station.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
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
