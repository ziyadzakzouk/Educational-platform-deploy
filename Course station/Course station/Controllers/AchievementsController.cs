using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Course_station.Models;
using System;
using System.Collections.Generic;

namespace Course_station.Controllers
{
    public class AchievementsController : Controller
    {
        // GET: AchievementsController
        public IActionResult Index()
        {
            var model = GetAchievements(); // Ensure this method returns a non-null list
            return View(model);
        }

        // Method to get achievements
        private List<Achievement> GetAchievements()
        {
            // Simulate quest completion logic
            var achievements = new List<Achievement>();

            // Simulate learner completing a quest
            bool questCompleted = true; // This would be replaced with actual quest completion logic

            if (questCompleted)
            {
                achievements.Add(new Achievement
                {
                    Description = "Quest Completed Achievement",
                    DateEarned = DateOnly.FromDateTime(DateTime.Now),
                    BadgeId = 1, // Assign appropriate BadgeId
                    LearnerId = 1 // Assign appropriate LearnerId
                });
            }

            achievements.Add(new Achievement
            {
                Description = "Achievement 1",
                DateEarned = DateOnly.FromDateTime(DateTime.Now),
                BadgeId = 1,
                LearnerId = 1
            });

            achievements.Add(new Achievement
            {
                Description = "Achievement 2",
                DateEarned = DateOnly.FromDateTime(DateTime.Now),
                BadgeId = 2,
                LearnerId = 2
            });

            return achievements;
        }


        // GET: AchievementsController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: AchievementsController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: AchievementsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: AchievementsController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: AchievementsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: AchievementsController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: AchievementsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}


//using Microsoft.AspNetCore.Http;
//using Microsoft.AspNetCore.Mvc;
//using Course_station.Models;
//using System;
//using System.Collections.Generic;
//using System.Linq;

//namespace Course_station.Controllers
//{
//    public class AchievementsController : Controller
//    {
//        private readonly ApplicationDbContext _context;

//        public AchievementsController(ApplicationDbContext context)
//        {
//            _context = context;
//        }

//        // GET: AchievementsController
//        public IActionResult Index()
//        {
//            var learnerId = HttpContext.Session.GetInt32("LearnerId");
//            if (learnerId == null)
//            {
//                return RedirectToAction("Login", "Learners");
//            }

//            var model = GetAchievements((int)learnerId); // Pass the learner ID
//            return View(model);
//        }

//        // Method to get achievements
//        private List<Achievement> GetAchievements(int learnerId)
//        {
//            // Simulate quest completion logic
//            var achievements = new List<Achievement>();

//            // Simulate learner completing a quest
//            bool questCompleted = true; // This would be replaced with actual quest completion logic

//            if (questCompleted)
//            {
//                var questAchievement = new Achievement
//                {
//                    Description = "Quest Completed Achievement",
//                    DateEarned = DateOnly.FromDateTime(DateTime.Now),
//                    BadgeId = 1, // Assign appropriate BadgeId
//                    LearnerId = learnerId // Use the provided learner ID
//                };

//                // Add the achievement to the learner's profile
//                var learner = _context.Learners.FirstOrDefault(l => l.LearnerId == learnerId);
//                if (learner != null)
//                {
//                    learner.Achievements.Add(questAchievement);
//                    _context.SaveChanges();
//                }

//                achievements.Add(questAchievement);
//            }

//            achievements.Add(new Achievement
//            {
//                Description = "Achievement 1",
//                DateEarned = DateOnly.FromDateTime(DateTime.Now),
//                BadgeId = 1,
//                LearnerId = learnerId
//            });

//            achievements.Add(new Achievement
//            {
//                Description = "Achievement 2",
//                DateEarned = DateOnly.FromDateTime(DateTime.Now),
//                BadgeId = 2,
//                LearnerId = learnerId
//            });

//            return achievements;
//        }

//        // GET: AchievementsController/Details/5
//        public ActionResult Details(int id)
//        {
//            return View();
//        }

//        // GET: AchievementsController/Create
//        public ActionResult Create()
//        {
//            return View();
//        }

//        // POST: AchievementsController/Create
//        [HttpPost]
//        [ValidateAntiForgeryToken]
//        public ActionResult Create(IFormCollection collection)
//        {
//            try
//            {
//                return RedirectToAction(nameof(Index));
//            }
//            catch
//            {
//                return View();
//            }
//        }

//        // GET: AchievementsController/Edit/5
//        public ActionResult Edit(int id)
//        {
//            return View();
//        }

//        // POST: AchievementsController/Edit/5
//        [HttpPost]
//        [ValidateAntiForgeryToken]
//        public ActionResult Edit(int id, IFormCollection collection)
//        {
//            try
//            {
//                return RedirectToAction(nameof(Index));
//            }
//            catch
//            {
//                return View();
//            }
//        }

//        // GET: AchievementsController/Delete/5
//        public ActionResult Delete(int id)
//        {
//            return View();
//        }

//        // POST: AchievementsController/Delete/5
//        [HttpPost]
//        [ValidateAntiForgeryToken]
//        public ActionResult Delete(int id, IFormCollection collection)
//        {
//            try
//            {
//                return RedirectToAction(nameof(Index));
//            }
//            catch
//            {
//                return View();
//            }
//        }
//    }
//}
