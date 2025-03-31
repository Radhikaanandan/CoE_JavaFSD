import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-menu-bar',
  templateUrl: './menu-bar.component.html',
  styleUrls: ['./menu-bar.component.css']
})
export class MenuBarComponent {
  status: boolean = false;
  loginmenu: string = 'Login';
  username: string | null = null;

  constructor(private router: Router) {
    this.username = localStorage.getItem('username');
    if (this.username) {
      this.status = true;
      this.loginmenu = `${this.username}, Logout`;
    }
  }

  loginhandler() {
    if (this.status) {
      localStorage.removeItem('username');
      window.location.reload();
    } else {
      this.router.navigate(['/login']);
    }
  }
}
