using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class CoursePrerequisiteController : Controller
    {
        private readonly ApplicationDbContext _context;

        public CoursePrerequisiteController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: CoursePrerequisite
        public async Task<IActionResult> Index()
        {
            var coursePrerequisites = _context.CoursePrerequisites.Include(c => c.Course);
            return View(await coursePrerequisites.ToListAsync());
        }

        // GET: CoursePrerequisite/Details/5
        public async Task<IActionResult> Details(int? courseId, string prerequisite)
        {
            if (courseId == null || prerequisite == null)
            {
                return NotFound();
            }

            var coursePrerequisite = await _context.CoursePrerequisites
                .Include(c => c.Course)
                .FirstOrDefaultAsync(m => m.CourseId == courseId && m.Prerequisite == prerequisite);
            if (coursePrerequisite == null)
            {
                return NotFound();
            }

            return View(coursePrerequisite);
        }

        // GET: CoursePrerequisite/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: CoursePrerequisite/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CourseId,Prerequisite")] CoursePrerequisite coursePrerequisite)
        {
            if (ModelState.IsValid)
            {
                _context.Add(coursePrerequisite);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(coursePrerequisite);
        }

        // GET: CoursePrerequisite/Edit/5
        public async Task<IActionResult> Edit(int? courseId, string prerequisite)
        {
            if (courseId == null || prerequisite == null)
            {
                return NotFound();
            }

            var coursePrerequisite = await _context.CoursePrerequisites.FindAsync(courseId, prerequisite);
            if (coursePrerequisite == null)
            {
                return NotFound();
            }
            return View(coursePrerequisite);
        }

        // POST: CoursePrerequisite/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int courseId, string prerequisite, [Bind("CourseId,Prerequisite")] CoursePrerequisite coursePrerequisite)
        {
            if (courseId != coursePrerequisite.CourseId || prerequisite != coursePrerequisite.Prerequisite)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(coursePrerequisite);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CoursePrerequisiteExists(coursePrerequisite.CourseId, coursePrerequisite.Prerequisite))
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
            return View(coursePrerequisite);
        }

        // GET: CoursePrerequisite/Delete/5
        public async Task<IActionResult> Delete(int? courseId, string prerequisite)
        {
            if (courseId == null || prerequisite == null)
            {
                return NotFound();
            }

            var coursePrerequisite = await _context.CoursePrerequisites
                .Include(c => c.Course)
                .FirstOrDefaultAsync(m => m.CourseId == courseId && m.Prerequisite == prerequisite);
            if (coursePrerequisite == null)
            {
                return NotFound();
            }

            return View(coursePrerequisite);
        }

        // POST: CoursePrerequisite/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int courseId, string prerequisite)
        {
            var coursePrerequisite = await _context.CoursePrerequisites.FindAsync(courseId, prerequisite);
            _context.CoursePrerequisites.Remove(coursePrerequisite);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CoursePrerequisiteExists(int courseId, string prerequisite)
        {
            return _context.CoursePrerequisites.Any(e => e.CourseId == courseId && e.Prerequisite == prerequisite);
        }
    }
}
