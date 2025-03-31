import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  username: string = '';
  password: string = '';
  errorMessage: string = '';

  validCredentials: { [key: string]: string } = {
    admin: 'admin123',
    user: 'user123'
  };

  login(): void {
    if (this.validCredentials[this.username] === this.password) {
      localStorage.setItem('username', this.username);
      window.location.reload();
    } else {
      this.errorMessage = 'Invalid Credentials';
    }
  }
}
