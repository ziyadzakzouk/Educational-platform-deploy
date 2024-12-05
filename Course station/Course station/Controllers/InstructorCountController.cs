using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class InstructorCountController : Controller
    {
        private readonly ApplicationDbContext _context;

        public InstructorCountController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: InstructorCount
        public async Task<IActionResult> Index()
        {
            return View(await _context.InstructorCounts.ToListAsync());
        }

        // GET: InstructorCount/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var instructorCount = await _context.InstructorCounts
                .FirstOrDefaultAsync(m => m.CourseId == id);
            if (instructorCount == null)
            {
                return NotFound();
            }

            return View(instructorCount);
        }

        // GET: InstructorCount/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: InstructorCount/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CourseId,Title,InstructorCount1")] InstructorCount instructorCount)
        {
            if (ModelState.IsValid)
            {
                _context.Add(instructorCount);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(instructorCount);
        }

        // GET: InstructorCount/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var instructorCount = await _context.InstructorCounts.FindAsync(id);
            if (instructorCount == null)
            {
                return NotFound();
            }
            return View(instructorCount);
        }

        // POST: InstructorCount/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CourseId,Title,InstructorCount1")] InstructorCount instructorCount)
        {
            if (id != instructorCount.CourseId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(instructorCount);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!InstructorCountExists(instructorCount.CourseId))
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
            return View(instructorCount);
        }

        // GET: InstructorCount/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var instructorCount = await _context.InstructorCounts
                .FirstOrDefaultAsync(m => m.CourseId == id);
            if (instructorCount == null)
            {
                return NotFound();
            }

            return View(instructorCount);
        }

        // POST: InstructorCount/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var instructorCount = await _context.InstructorCounts.FindAsync(id);
            _context.InstructorCounts.Remove(instructorCount);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool InstructorCountExists(int id)
        {
            return _context.InstructorCounts.Any(e => e.CourseId == id);
        }
    }
}
