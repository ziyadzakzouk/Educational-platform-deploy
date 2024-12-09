using Microsoft.AspNetCore.Mvc;
using Course_station.Models;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Controllers
{
    [Route("Learners/{learnerId}/[controller]")]
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

        // GET: Learners/{learnerId}/PersonalProfile/Create
        [HttpGet("Create")]
        public IActionResult Create(int learnerId)
        {
            ViewBag.LearnerId = learnerId;
            return View();
        }

        // POST: Learners/{learnerId}/PersonalProfile/Create
        [HttpPost("Create")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(int learnerId, [Bind("ProfileId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            if (ModelState.IsValid)
            {
                personalProfile.LearnerId = learnerId;
                _context.Add(personalProfile);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index), new { learnerId });
            }
            ViewBag.LearnerId = learnerId;
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
