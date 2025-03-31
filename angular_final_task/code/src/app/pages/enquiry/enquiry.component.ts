import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../../app/services/api.service';

@Component({
  selector: 'app-enquiry',
  templateUrl: './enquiry.component.html',
  styleUrl: './enquiry.component.css'
})
export class EnquiryComponent {
  enquiries: any[] = [];

  constructor(private apiService: ApiService) { }

  ngOnInit(): void {
    // Fetch the enquiry responses when the component loads
    this.getEnquiryResponses();
  }

  getEnquiryResponses(): void {
    this.apiService.getEnquiries().subscribe((data: any[]) => {
      this.enquiries = data;
    }, error => {
      console.error('Error fetching enquiry responses:', error);
    });
  }

}
