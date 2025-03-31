import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  constructor(private http: HttpClient) {}
  
  // Fetch achievements from API
  getAchievements(): Observable<any> {
    return this.http.get('http://localhost:3000/achievements');
  }
  getBook(): Observable<any>{
    return this.http.get('http://localhost:3000/books');
  }
  getDetail(id: string):Observable<any>{
    return this.http.get(`http://localhost:3000/details?id=${id}`);
  }
  submitEnquiry(enquiry: any): Observable<any>{
    return this.http.post('http://localhost:3000/enquiryresponse', enquiry);
  }
  getEnquiries(): Observable<any>{
    return this.http.get('http://localhost:3000/enquiryresponse');
    
  } 
}
