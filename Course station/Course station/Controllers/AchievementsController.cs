using Microsoft.AspNetCore.Mvc;
using Course_station.Models;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace Course_station.Controllers
{
    public class AchievementController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AchievementController(ApplicationDbContext context)
        {
            _context = context;
        }

        // List all achievements
        public async Task<IActionResult> Index()
        {
            var achievements = await _context.Achievements.ToListAsync();
            return View(achievements);
        }

        // Details of a single achievement
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var achievement = await _context.Achievements
                .FirstOrDefaultAsync(a => a.AchievementId == id);
            if (achievement == null)
            {
                return NotFound();
            }

            return View(achievement);
        }

        // Create achievement - GET
        public IActionResult Create()
        {
            return View();
        }

        // Create achievement - POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Achievement achievement)
        {
            if (ModelState.IsValid)
            {
                _context.Add(achievement);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(achievement);
        }

        // Edit achievement - GET
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var achievement = await _context.Achievements.FindAsync(id);
            if (achievement == null)
            {
                return NotFound();
            }
            return View(achievement);
        }

        // Edit achievement - POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AchievementId,Title,Description")] Achievement achievement)
        {
            if (id != achievement.AchievementId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(achievement);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AchievementExists(achievement.AchievementId))
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
            return View(achievement);
        }

        // Delete achievement - GET
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var achievement = await _context.Achievements
                .FirstOrDefaultAsync(a => a.AchievementId == id);
            if (achievement == null)
            {
                return NotFound();
            }

            return View(achievement);
        }

        // Delete achievement - POST
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var achievement = await _context.Achievements.FindAsync(id);
            _context.Achievements.Remove(achievement);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AchievementExists(int id)
        {
            return _context.Achievements.Any(e => e.AchievementId == id);
        }
    }
}
