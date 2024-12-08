using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Course_station.Models;
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

        // GET: PersonalProfile
        public async Task<IActionResult> Index()
        {
            return View(await _context.PersonalProfiles.ToListAsync());
        }

        // GET: PersonalProfile/Details/5
        public async Task<IActionResult> Details(int? id)
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

            return View(personalProfile);
        }

        // GET: PersonalProfile/Create/{learnerId}
        [HttpGet("PersonalProfile/Create/{learnerId}")]
        public IActionResult Create(int learnerId)
        {
            var personalProfile = new PersonalProfile
            {
                LearnerId = learnerId
            };
            return View(personalProfile);
        }

        // POST: PersonalProfile/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PreferedContentType,EmotionalState,PersonalityType,LearnerId")] PersonalProfile personalProfile)
        {
            if (ModelState.IsValid)
            {
                _context.Add(personalProfile);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(personalProfile);
        }

        public async Task<IActionResult> Edit(int? id, int? anotherKey)
        {
            if (id == null || anotherKey == null)
            {
                return NotFound();
            }

            var personalProfile = await _context.PersonalProfiles.FindAsync(id, anotherKey);
            if (personalProfile == null)
            {
                return NotFound();
            }
            return View(personalProfile);
        }

        // POST: PersonalProfile/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ProfileId,PreferedContentType,EmotionalState,PersonalityType")] PersonalProfile personalProfile)
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
            return View(personalProfile);
        }

        // GET: PersonalProfile/Delete/5
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

            return View(personalProfile);
        }

        // POST: PersonalProfile/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var personalProfile = await _context.PersonalProfiles.FindAsync(id);
            _context.PersonalProfiles.Remove(personalProfile);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PersonalProfileExists(int id)
        {
            return _context.PersonalProfiles.Any(e => e.ProfileId == id);
        }
    }
}
