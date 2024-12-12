using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Course_station.Models;

namespace Course_station.Controllers
{
    public class AssessmentsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AssessmentsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Assessments
        public async Task<IActionResult> Index()
        {
            return View(await _context.Assessments.ToListAsync());
        }

        // GET: Assessments/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessment = await _context.Assessments
                .Include(a => a.TakenAssessments)
                .FirstOrDefaultAsync(m => m.AssessmentId == id);

            if (assessment == null)
            {
                return NotFound();
            }

            return View(assessment);
        }

        // GET: Assessments/Take/5
        public async Task<IActionResult> Take(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessment = await _context.Assessments
                .FirstOrDefaultAsync(m => m.AssessmentId == id);

            if (assessment == null)
            {
                return NotFound();
            }

            // Assuming you have a way to get the logged-in learner's ID
            var learnerId = HttpContext.Session.GetInt32("LearnerId") ?? 0;

            var takenAssessment = new TakenAssessment
            {
                AssessmentId = assessment.AssessmentId,
                LearnerId = learnerId
            };

            return View(takenAssessment);
        }


        // POST: Assessments/Take/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Take(int id, [Bind("AssessmentId,LearnerId,ScoredPoint")] TakenAssessment takenAssessment)
        {
            if (ModelState.IsValid)
            {
                _context.TakenAssessments.Add(takenAssessment);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(takenAssessment);
        }

        // GET: Assessments/ViewScore
        public async Task<IActionResult> ViewScore(int learnerId, int assessmentId)
        {
            var takenAssessment = await _context.TakenAssessments
                .Include(ta => ta.Assessment)
                .FirstOrDefaultAsync(ta => ta.LearnerId == learnerId && ta.AssessmentId == assessmentId);

            if (takenAssessment == null)
            {
                return NotFound();
            }

            return View(takenAssessment);
        }
    }
}
