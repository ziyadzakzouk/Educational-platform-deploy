using Course_station.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace Course_station.Controllers
{
    public class PersonalProfileController : Controller
    {
        private readonly ApplicationDbContext _context;

        public PersonalProfileController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var personalProfiles = await _context.PersonalProfiles.Include(p => p.Learner).ToListAsync();
            return View(personalProfiles);
        }

        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles
                .Include(p => p.Learner)
                .FirstOrDefaultAsync(m => m.ProfileId == id);
            if (personalProfile == null)
            {
                return NotFound();
            }

            return View(personalProfile);
        }

        public IActionResult Create()
        {
            ViewData["Title"] = "Create Personal Profile";
            return View(new PersonalProfile());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ProfileId,LearnerId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            if (ModelState.IsValid)
            {
                _context.Add(personalProfile);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["Title"] = "Create Personal Profile";
            return View(personalProfile);
        }

        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles.FindAsync(id); //passed value should be 2 not 1
            if (personalProfile == null)
            {
                return NotFound();
            }

            ViewData["Title"] = "Edit Personal Profile";
            return View(personalProfile);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ProfileId,LearnerId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
        {
            if (id != personalProfile.ProfileId)
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
                return RedirectToAction(nameof(Index));
            }
            ViewData["Title"] = "Edit Personal Profile";
            return View(personalProfile);
        }

        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles
                .FirstOrDefaultAsync(m => m.ProfileId == id);
            if (personalProfile == null)
            {
                return NotFound();
            }

            ViewData["Title"] = "Delete Personal Profile";
            return View(personalProfile);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var personalProfile = await _context.PersonalProfiles.FindAsync(id);
            if (personalProfile != null)
            {
                _context.PersonalProfiles.Remove(personalProfile);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }

        private bool PersonalProfileExists(int id)
        {
            return _context.PersonalProfiles.Any(e => e.ProfileId == id);
        }
    }
}
