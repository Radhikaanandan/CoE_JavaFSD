import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> | Promise<boolean> | boolean {
    
    const username = localStorage.getItem('username');
    
    // Check if the user is logged in and has admin credentials
    if (username === 'admin') {
      return true; // Allow access to the route
    } else if (username === 'user') {
      
      this.router.navigate(['/']);
      return false;
    } else {
      // If no one is logged in, redirect to login page
      this.router.navigate(['/login']);
      return false;
    }
  }
}
