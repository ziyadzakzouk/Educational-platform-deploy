using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class PersonalProfileController : Controller
    {
        private readonly ApplicationDbContext _context;

        public PersonalProfileController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: PersonalProfile
        public async Task<IActionResult> Index()
        {
            var personalProfiles = _context.PersonalProfiles.Include(p => p.Learner);
            return View(await personalProfiles.ToListAsync());
        }

        // GET: PersonalProfile/Details/5
        public async Task<IActionResult> Details(int? learnerId, int? profileId)
        {
            if (learnerId == null || profileId == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles
                .Include(p => p.Learner)
                .FirstOrDefaultAsync(m => m.LearnerId == learnerId && m.ProfileId == profileId);
            if (personalProfile == null)
            {
                return NotFound();
            }

            return View(personalProfile);
        }

        // GET: PersonalProfile/Create
        public IActionResult Create(int learnerId)
        {
            var personalProfile = new PersonalProfile { LearnerId = learnerId };
            return View(personalProfile);
        }

        // POST: PersonalProfile/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(int learnerId, [Bind("ProfileId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            personalProfile.LearnerId = learnerId;

            if (ModelState.IsValid)
            {
                _context.Add(personalProfile);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(personalProfile);
        }

        // GET: PersonalProfile/Edit/5
        public async Task<IActionResult> Edit(int? learnerId, int? profileId)
        {
            if (learnerId == null || profileId == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles.FindAsync(learnerId, profileId);
            if (personalProfile == null)
            {
                return NotFound();
            }
            return View(personalProfile);
        }

        // POST: PersonalProfile/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int learnerId, int profileId, [Bind("LearnerId,ProfileId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            if (learnerId != personalProfile.LearnerId || profileId != personalProfile.ProfileId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(personalProfile);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!PersonalProfileExists(personalProfile.LearnerId, personalProfile.ProfileId))
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
            return View(personalProfile);
        }

        // GET: PersonalProfile/Delete/5
        public async Task<IActionResult> Delete(int? learnerId, int? profileId)
        {
            if (learnerId == null || profileId == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles
                .Include(p => p.Learner)
                .FirstOrDefaultAsync(m => m.LearnerId == learnerId && m.ProfileId == profileId);
            if (personalProfile == null)
            {
                return NotFound();
            }

            return View(personalProfile);
        }

        // POST: PersonalProfile/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int learnerId, int profileId)
        {
            var personalProfile = await _context.PersonalProfiles.FindAsync(learnerId, profileId);
            _context.PersonalProfiles.Remove(personalProfile);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PersonalProfileExists(int learnerId, int profileId)
        {
            return _context.PersonalProfiles.Any(e => e.LearnerId == learnerId && e.ProfileId == profileId);
        }
    }
}
