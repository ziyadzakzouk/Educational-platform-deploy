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
            var personalProfiles = await _context.PersonalProfiles.Include(p => p.Learner).ToListAsync();
            return View(personalProfiles);
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
        public IActionResult Create()
        {
            return View();
        }

        // POST: PersonalProfile/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ProfileId,LearnerId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            if (ModelState.IsValid)
            {
                _context.Add(personalProfile);
                await _context.SaveChangesAsync();
                return RedirectToAction("Index");
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

            var personalProfile = await _context.PersonalProfiles
                .FirstOrDefaultAsync(m => m.LearnerId == learnerId && m.ProfileId == profileId);
            if (personalProfile == null)
            {
                return NotFound();
            }
            return View(personalProfile);
        }


        // POST: PersonalProfile/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int profileId, [Bind("ProfileId,LearnerId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            if (profileId != personalProfile.ProfileId)
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
                    if (!PersonalProfileExists(personalProfile.ProfileId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction("Index");
            }
            return View(personalProfile);
        }

        // GET: PersonalProfile/Delete/5
        public async Task<IActionResult> Delete(int? profileId)
        {
            if (profileId == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles
                .Include(p => p.Learner)
                .FirstOrDefaultAsync(m => m.ProfileId == profileId);
            if (personalProfile == null)
            {
                return NotFound();
            }

            return View(personalProfile);
        }

        // POST: PersonalProfile/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int profileId)
        {
            var personalProfile = await _context.PersonalProfiles
                .FirstOrDefaultAsync(m => m.ProfileId == profileId);
            if (personalProfile != null)
            {
                _context.PersonalProfiles.Remove(personalProfile);
                await _context.SaveChangesAsync();
            }
            else
            {
                return NotFound();
            }
            return RedirectToAction(nameof(Index));
        }

        private bool PersonalProfileExists(int profileId)
        {
            return _context.PersonalProfiles.Any(e => e.ProfileId == profileId);
        }
    }
}
