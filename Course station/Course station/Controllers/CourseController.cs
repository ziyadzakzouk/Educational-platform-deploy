using Microsoft.AspNetCore.Mvc;
using Course_station.Models;
using Microsoft.EntityFrameworkCore;


namespace Course_station.Controllers
{
    public class CourseController : Controller //CRUD CLASS
        //Create a course
        //Read a course
        //Update a course
        //Delete a course
        //More ....
    {
        private readonly ApplicationDbContext _context;

        public CourseController(ApplicationDbContext context)
        {
            this._context = context;
        }

        public IActionResult Index() //get the course
        {
            var courses = _context.Courses.ToList();
            return View(courses);
        }

        
        public async Task<IActionResult> Details(int? id)  ///to get the details of the course
        {
            if (id == null)
            {
                return NotFound();
            }

            var course = await _context.Courses
                .FirstOrDefaultAsync(m => m.CourseId == id);
            if (course == null)
            {
                return NotFound();
            }

            return View(course);
        }

        // GET: Courses/Create
        public IActionResult Create()
        {
            return View();
        }


        [HttpPost]
        public async Task<IActionResult> Create(Course course) //create a course
        {
            if (ModelState.IsValid)
            {
                _context.Add(course);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(course);
        }

        [HttpPost]
        public async Task<IActionResult> Edit(int id, Course course)
        {
            if (id != course.CourseId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                _context.Update(course);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(course);
        }

        [HttpPost]
        public async Task<IActionResult> Delete(int id)
        {
            var course = await _context.Courses.FindAsync(id);
            _context.Courses.Remove(course);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
        }
}
