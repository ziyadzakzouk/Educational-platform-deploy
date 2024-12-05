using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class LearnersController : Controller
    {
        private readonly ApplicationDbContext _context;

        public LearnersController(ApplicationDbContext context)
        {
            _context = context;
        }

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
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
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
            public async Task<IActionResult> UpdateProfile(int learnerId, int profileId, string preferredContentType, string emotionalState, string personalityType)
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC ProfileUpdate @LearnerID = {0}, @ProfileID = {1}, @PreferedContentType = {2}, @emotional_state = {3}, @PersonalityType = {4}",
                    learnerId, profileId, preferredContentType, emotionalState, personalityType
                );

                return RedirectToAction("ViewInfo", new { learnerId });
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

            // Additional actions can be implemented similarly
        }

    }

