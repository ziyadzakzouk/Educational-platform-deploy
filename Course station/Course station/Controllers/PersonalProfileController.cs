using Microsoft.AspNetCore.Mvc;
using Course_station.Models;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Controllers
{
   
    public class PersonalProfileController : Controller
    {
        private readonly ApplicationDbContext _context;

        public PersonalProfileController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Learners/{learnerId}/PersonalProfile
        [HttpGet]
        public async Task<IActionResult> Index(int learnerId)
        {
            var personalProfiles = await _context.PersonalProfiles
                .Where(p => p.LearnerId == learnerId)
                .ToListAsync();
            ViewBag.LearnerId = learnerId;
            return View(personalProfiles);
        }

        [HttpGet("PersonalProfile/Create/{learnerId}")]
        public IActionResult Create(int learnerId)
        {
            var personalProfile = new PersonalProfile
            {
                LearnerId = learnerId
            };
            return View(personalProfile);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PreferedContentType,EmotionalState,PersonalityType,LearnerId")] PersonalProfile personalProfile)
        {
            if (personalProfile.LearnerId == 0)
            {
                ModelState.AddModelError("LearnerId", "LearnerId is required.");
            }

            if (ModelState.IsValid)
            {
                _context.Add(personalProfile);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            // Console.WriteLine(personalProfile.GetType()); // Should output PersonalProfile
            return View(personalProfile);
        }

        // GET: Learners/{learnerId}/PersonalProfile/Delete/5
        [HttpGet("Delete/{id}")]
        public async Task<IActionResult> Delete(int learnerId, int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles
                .FirstOrDefaultAsync(m => m.ProfileId == id && m.LearnerId == learnerId);
            if (personalProfile == null)
            {
                return NotFound();
            }

            ViewBag.LearnerId = learnerId;
            return View(personalProfile);
        }

        // POST: Learners/{learnerId}/PersonalProfile/Delete/5
        [HttpPost("Delete/{id}"), ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int learnerId, int id)
        {
            var personalProfile = await _context.PersonalProfiles
                .FirstOrDefaultAsync(m => m.ProfileId == id && m.LearnerId == learnerId);
            if (personalProfile != null)
            {
                _context.PersonalProfiles.Remove(personalProfile);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index), new { learnerId });
        }
    }
}
