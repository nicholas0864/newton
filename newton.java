public class newton {

    // Polynomial function f(x) = 2x^3 - 3x^2 + 5x - 1
    public static double f(double x) {
        return 2 * Math.pow(x, 3) - 3 * Math.pow(x, 2) + 5 * x - 1;
    }

    // Derivative f'(x) = 6x^2 - 6x + 5
    public static double fPrime(double x) {
        return 6 * Math.pow(x, 2) - 6 * x + 5;
    }

    // newton raphson method
    public static Double newtonRaphson(double x0, double tolerance, int maxIterations) {
        double x_n = x0;
        
        for (int n = 1; n <= maxIterations; n++) {
            double fx_n = f(x_n);
            double fPrime_x_n = fPrime(x_n);
            
            // avoid div by 0
            if (fPrime_x_n == 0) {
                System.out.println("Derivative is zero, cannot continue.");
                return null;
            }
            
            
            double x_next = x_n - fx_n / fPrime_x_n;
            
           
            if (Math.abs(x_next - x_n) < tolerance) {
                System.out.println("Root found: " + x_next + " (after " + n + " iterations)");
                return x_next;
            }
            
            x_n = x_next; // update to new guess
        }
        
        System.out.println("Max iterations reached, root not found.");
        return null;
    }

    public static void main(String[] args) {
        double initialGuess = 0.5;
        double tolerance = 1e-10;
        int maxIterations = 10000000;

        long nanos = System.nanoTime();
        Double root = newtonRaphson(initialGuess, tolerance, maxIterations);
        long duration = System.nanoTime() - nanos;
        int seconds = (int) (duration / 1000000000);
        int milliseconds = (int) (duration / 1000000) % 1000;
        int nanoseconds = (int) (duration % 1000000);
        System.out.printf("%d seconds, %d milliseconds en %d nanoseconds\n", seconds, milliseconds, nanoseconds);
        if (root != null) {
            System.out.println("Approximate root: " + root);
        }
    }


}