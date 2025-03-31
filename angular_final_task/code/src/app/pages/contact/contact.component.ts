import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiService } from '../../services/api.service';  // Adjust the path based on your project structure

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrl: './contact.component.css'
})
export class ContactComponent {
  enquiry = {
    name: '',
    email: '',
    message: '',
  };

  constructor(private api: ApiService) {}

  onSubmit() {
    if (this.enquiry.name && this.enquiry.email && this.enquiry.message) {
      this.api.submitEnquiry(this.enquiry).subscribe({
        next: (response: any) => {
          console.log('Enquiry submitted:', response);
          alert('Thank you for your enquiry! We will get back to you soon.');
          this.resetForm();
        },
        error: (error: any) => {
          console.error('Submission error:', error);
          alert('There was an error submitting your enquiry.');
        }
      });
    } else {
      alert('Please fill out all the fields.');
    }
  }

  resetForm() {
    this.enquiry = { name: '', email: '', message: '' };
  }

}
