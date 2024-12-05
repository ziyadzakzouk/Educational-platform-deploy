using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class ModuleController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ModuleController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Module
        public async Task<IActionResult> Index()
        {
            var modules = _context.Modules.Include(m => m.Course);
            return View(await modules.ToListAsync());
        }

        // GET: Module/Details/5
        public async Task<IActionResult> Details(int? moduleId, int? courseId)
        {
            if (moduleId == null || courseId == null)
            {
                return NotFound();
            }

            var module = await _context.Modules
                .Include(m => m.Course)
                .FirstOrDefaultAsync(m => m.ModuleId == moduleId && m.CourseId == courseId);
            if (module == null)
            {
                return NotFound();
            }

            return View(module);
        }

        // GET: Module/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Module/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ModuleId,CourseId,Title,DifficultyLevel,ContentUrl")] Module module)
        {
            if (ModelState.IsValid)
            {
                _context.Add(module);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(module);
        }

        // GET: Module/Edit/5
        public async Task<IActionResult> Edit(int? moduleId, int? courseId)
        {
            if (moduleId == null || courseId == null)
            {
                return NotFound();
            }

            var module = await _context.Modules.FindAsync(moduleId, courseId);
            if (module == null)
            {
                return NotFound();
            }
            return View(module);
        }

        // POST: Module/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int moduleId, int courseId, [Bind("ModuleId,CourseId,Title,DifficultyLevel,ContentUrl")] Module module)
        {
            if (moduleId != module.ModuleId || courseId != module.CourseId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(module);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ModuleExists(module.ModuleId, module.CourseId))
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
            return View(module);
        }

        // GET: Module/Delete/5
        public async Task<IActionResult> Delete(int? moduleId, int? courseId)
        {
            if (moduleId == null || courseId == null)
            {
                return NotFound();
            }

            var module = await _context.Modules
                .Include(m => m.Course)
                .FirstOrDefaultAsync(m => m.ModuleId == moduleId && m.CourseId == courseId);
            if (module == null)
            {
                return NotFound();
            }

            return View(module);
        }

        // POST: Module/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int moduleId, int courseId)
        {
            var module = await _context.Modules.FindAsync(moduleId, courseId);
            _context.Modules.Remove(module);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ModuleExists(int moduleId, int courseId)
        {
            return _context.Modules.Any(e => e.ModuleId == moduleId && e.CourseId == courseId);
        }
    }
}
