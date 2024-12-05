using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class AssessmentController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AssessmentController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Assessment
        public async Task<IActionResult> Index()
        {
            var assessments = _context.Assessments.Include(a => a.Module);
            return View(await assessments.ToListAsync());
        }

        // GET: Assessment/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessment = await _context.Assessments
                .Include(a => a.Module)
                .FirstOrDefaultAsync(m => m.AssessmentId == id);
            if (assessment == null)
            {
                return NotFound();
            }

            return View(assessment);
        }

        // GET: Assessment/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Assessment/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AssessmentId,ModuleId,CourseId,Type,TotalMarks,PassingMarks,Criteria,Weightage,Description,Title")] Assessment assessment)
        {
            if (ModelState.IsValid)
            {
                _context.Add(assessment);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(assessment);
        }

        // GET: Assessment/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessment = await _context.Assessments.FindAsync(id);
            if (assessment == null)
            {
                return NotFound();
            }
            return View(assessment);
        }

        // POST: Assessment/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AssessmentId,ModuleId,CourseId,Type,TotalMarks,PassingMarks,Criteria,Weightage,Description,Title")] Assessment assessment)
        {
            if (id != assessment.AssessmentId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(assessment);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AssessmentExists(assessment.AssessmentId))
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
            return View(assessment);
        }

        // GET: Assessment/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessment = await _context.Assessments
                .Include(a => a.Module)
                .FirstOrDefaultAsync(m => m.AssessmentId == id);
            if (assessment == null)
            {
                return NotFound();
            }

            return View(assessment);
        }

        // POST: Assessment/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var assessment = await _context.Assessments.FindAsync(id);
            _context.Assessments.Remove(assessment);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AssessmentExists(int id)
        {
            return _context.Assessments.Any(e => e.AssessmentId == id);
        }
    }
}
