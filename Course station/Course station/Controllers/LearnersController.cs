using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Course_station.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;

namespace Course_station.Controllers
{
    
    public class LearnersController : Controller
    {
       
        private readonly ApplicationDbContext _context;
        private readonly LearnerService _learnerService;

        public LearnersController(ApplicationDbContext context, LearnerService learnerService)
        {
            _context = context;
            _learnerService = learnerService;
        }
     //   [Authorize(Roles = "Learner")]
        public IActionResult Home()
        {
            return View();
        }

        [Authorize(Roles = "Admin")]
        // GET: Learners
        public async Task<IActionResult> Index()
        {
            return View(await _context.Learners.ToListAsync());
        }

        // GET: Learners/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learner = await _context.Learners
                .FirstOrDefaultAsync(m => m.LearnerId == id);
            if (learner == null)
            {
                return NotFound();
            }

            return View(learner);
        }

        // GET: Learners/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Learners/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("LearnerId,FirstName,LastName,Birthday,Gender,Country,CulturalBackground,Password,Email")] Learner learner)
        {
            if (ModelState.IsValid)
            {
                _context.Add(learner);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(learner);
        }


        // GET: Learners/Login
        public IActionResult Login()
        {
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(int learnerId, string password)
        {
            if (ModelState.IsValid)
            {
                var learner = await _context.Learners.FirstOrDefaultAsync(l => l.LearnerId == learnerId && l.Password == password);

                if (learner != null)
                {
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, learner.FirstName + " " + learner.LastName),
                        new Claim(ClaimTypes.Role, "Learner")
                    };

                    var claimsIdentity = new ClaimsIdentity(claims, "Login");
                    var claimsPrincipal = new ClaimsPrincipal(claimsIdentity);

                    await HttpContext.SignInAsync(claimsPrincipal);

                    TempData["Message"] = "Login successful!";
                    return RedirectToAction("Home", "Learners");
                }
                TempData["ErrorMessage"] = "Invalid login attempt.";
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            if (User.Identity?.Name != null)
            {
                // Clear user-specific cache or perform other cleanup tasks
                var cacheKey = $"UserCache_{User.Identity.Name}";
                // Assuming you have a cache service, you can clear the cache like this:
                // _cacheService.Remove(cacheKey);
            }

            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");
        }
        // GET: Learners/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learner = await _context.Learners.FindAsync(id);
            if (learner == null)
            {
                return NotFound();
            }
            return View(learner);
        }

        // POST: Learners/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("LearnerId,FirstName,LastName,Birthday,Gender,Country,CulturalBackground,Password,Email")] Learner learner)
        {
            if (id != learner.LearnerId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(learner);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!LearnerExists(learner.LearnerId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(learner);
        }

        // GET: Learners/Delete/5
        [Authorize]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learner = await _context.Learners
                .FirstOrDefaultAsync(m => m.LearnerId == id);
            if (learner == null)
            {
                return NotFound();
            }

            return View(learner);
        }

        // POST: Learners/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var learner = await _context.Learners.FindAsync(id);
            if (learner != null)
            {
                _context.Learners.Remove(learner);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool LearnerExists(int id)
        {
            return _context.Learners.Any(e => e.LearnerId == id);
        }
        

            // 1. Retrieve Learner Info
            public async Task<IActionResult> ViewInfo(int learnerId)
            {
                var learner = await _context.Learners
                    .FromSqlRaw("EXEC ViewInfo @LearnerID = {0}", learnerId)
                    .ToListAsync();

                return View(learner);
            }

            // 2. Update Profile
            public IActionResult UpdateProfile()
            {
                return View();
            }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UploadProfilePicture(int learnerId, IFormFile profilePicture)
        {
            if (profilePicture != null && profilePicture.Length > 0)
            {
                var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images");
                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                var filePath = Path.Combine(uploadsFolder, $"{learnerId}_profile.jpg");

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await profilePicture.CopyToAsync(stream);
                }

                TempData["Message"] = "Profile picture uploaded successfully!";
            }
            else
            {
                TempData["ErrorMessage"] = "Please select a valid image file.";
            }

            return RedirectToAction(nameof(Details), new { id = learnerId });
        }
        // 3. View Enrolled Courses
        public async Task<IActionResult> EnrolledCourses(int learnerId)
            {
                var courses = await _context.Courses
                    .FromSqlRaw("EXEC EnrolledCourses @LearnerID = {0}", learnerId)
                    .ToListAsync();

                return View(courses);
            }

            // 4. Check Prerequisites
            public async Task<IActionResult> CheckPrerequisites(int learnerId, int courseId)
            {
                var result = await _context.Database.ExecuteSqlRawAsync(
                    "EXEC Prerequisites @LearnerID = {0}, @CourseID = {1}",
                    learnerId, courseId
                );

                ViewBag.PrerequisitesResult = result;
                return View();
            }

        // 5. View all modules for a course that train specific traits
        public async Task<IActionResult> ModuleTraits(string targetTrait, int courseId)
        {
            var modules = await _context.Modules
                .FromSqlRaw("EXEC Moduletraits @TargetTrait = {0}, @CourseID = {1}", targetTrait, courseId)
                .ToListAsync();

            return View(modules);
        }

        // 6. View all participants in a leaderboard and their ranking
        public async Task<IActionResult> LeaderboardRank(int leaderboardId)
        {
            var rankings = await _context.Leaderboards
                .FromSqlRaw("EXEC LeaderboardRank @LeaderboardID = {0}", leaderboardId)
                .ToListAsync();

            return View(rankings);
        }

        // 7. Submit emotional feedback for an activity
        [HttpPost]
        public async Task<IActionResult> SubmitEmotionalFeedback(int activityId, int learnerId, string emotionalState)
        {
            await _context.Database.ExecuteSqlRawAsync(
                "EXEC ActivityEmotionalFeedback @ActivityID = {0}, @LearnerID = {1}, @timestamp = {2}, @emotionalstate = {3}",
                activityId, learnerId, DateTime.Now, emotionalState
            );

            TempData["Message"] = "Feedback submitted successfully!";
            return RedirectToAction("ActivityDetails", new { activityId });
        }

        // 8. Join a collaborative quest if space is available
        [HttpPost]
        public async Task<IActionResult> JoinQuest(int learnerId, int questId)
        {
            var result = await _context.Database.ExecuteSqlRawAsync(
                "EXEC JoinQuest @LearnerID = {0}, @QuestID = {1}",
                learnerId, questId
            );

            TempData["Message"] = result > 0 ? "Successfully joined the quest!" : "Quest is full.";
            return RedirectToAction("QuestDetails", new { questId });
        }

        // 9. View skill proficiency levels
        public async Task<IActionResult> SkillsProficiency(int learnerId)
        {
            var skills = await _context.Skills
                .FromSqlRaw("EXEC SkillsProfeciency @LearnerID = {0}", learnerId)
                .ToListAsync();

            return View(skills);
        }

        // 10. View assessment score
        public async Task<IActionResult> ViewScore(int learnerId, int assessmentId)
        {
            var score = await _context.Database.ExecuteSqlRawAsync(
                "EXEC Viewscore @LearnerID = {0}, @AssessmentID = {1}",
                learnerId, assessmentId
            );

            ViewBag.Score = score;
            return View();
        }

        // 11. View assessments and grades for a module
        public async Task<IActionResult> AssessmentsList(int courseId, int moduleId, int learnerId)
        {
            var assessments = await _context.Assessments
                .FromSqlRaw("EXEC AssessmentsList @CourseID = {0}, @ModuleID = {1}, @LearnerID = {2}",
                courseId, moduleId, learnerId)
                .ToListAsync();

            return View(assessments);
        }

        // 12. Register for a course
        [HttpPost]
        public async Task<IActionResult> RegisterCourse(int learnerId, int courseId)
        {
            var result = await _context.Database.ExecuteSqlRawAsync(
                "EXEC Courseregister @LearnerID = {0}, @CourseID = {1}",
                learnerId, courseId
            );

            TempData["Message"] = result > 0 ? "Registered successfully!" : "Could not register. Check prerequisites.";
            return RedirectToAction("CourseDetails", new { courseId });
        }
    }

    }

