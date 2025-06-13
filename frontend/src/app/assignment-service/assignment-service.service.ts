import {inject, Injectable} from '@angular/core';
import {CompanyServiceService} from '../company-service/company-service.service';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {Shift} from '../interfaces/shift';
import {Assignment} from '../interfaces/assignment';

@Injectable({
  providedIn: 'root'
})
export class AssignmentServiceService {

  companyService: CompanyServiceService = inject(CompanyServiceService);
  httpClient: HttpClient = inject(HttpClient);

  private getApiUrl(): string {
    return `http://localhost:8080/api/${this.companyService.getCompanyId()}`
  }


  getAssignmentByShiftId(shiftId: number): Observable<Assignment[]> {
    return this.httpClient.get<Assignment[]>(`${this.getApiUrl()}/assignments/shift/${shiftId}`)
  }
}
