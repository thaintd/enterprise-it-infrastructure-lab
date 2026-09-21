# Enterprise IT Infrastructure Lab

Portfolio tổng hợp quá trình tự xây dựng và vận hành một môi trường CNTT doanh nghiệp mô phỏng, trải từ hạ tầng on-premises truyền thống đến hybrid identity, bảo mật/compliance, hạ tầng Azure, và tự động hóa. Mỗi phần là 1 module độc lập, có bằng chứng ảnh chụp thực tế kèm theo.

## Cấu trúc project

| # | Module | Nội dung chính |
|---|--------|----------------|
| [01](./01-microsoft-365-administration) | Microsoft 365 Administration | Quản trị user, license, Exchange Online, Teams, SharePoint |
| [02](./02-onprem-active-directory) | On-Premises Active Directory | AD DS, OU/GPO, DNS, File Server, quản trị domain truyền thống |
| [03](./03-hybrid-identity-entra-connect) | Hybrid Identity (Entra Connect) | Đồng bộ identity on-prem ↔ cloud, Seamless SSO |
| [04](./04-security-compliance) | Security & Compliance | Conditional Access, Intune, Microsoft Defender, Purview DLP |
| [05](./05-azure-enterprise-hybrid-lab) | Azure Enterprise Hybrid Lab | Hạ tầng Azure độc lập: networking, compute, Arc, monitoring/backup — kèm Infrastructure as Code (Bicep) |
| [06](./06-automation-power-automate-copilot) | Automation (Power Automate + Copilot) | Tự động hóa quy trình bằng Copilot Studio / Power Automate |

## Lưu ý về kiến trúc

Module **05 (Azure Enterprise Hybrid Lab)** được dựng trên 1 subscription/tenant riêng (Azure for Students), **độc lập hoàn toàn** về mặt kỹ thuật với các module 01-04 và 06 (chạy trên tenant Microsoft 365/on-prem khác). Đây không phải 1 hệ thống hybrid thật kết nối 2 môi trường, mà là 2 lab riêng biệt thể hiện 2 nhóm kỹ năng khác nhau:
- **01-04, 06**: Quản trị Microsoft 365 + on-prem AD + hybrid identity + bảo mật + tự động hóa — theo hướng M365/Modern Workplace Administrator
- **05**: Thiết kế và vận hành hạ tầng Azure IaaS/PaaS theo mô hình hub-spoke doanh nghiệp — theo hướng Azure Administrator (AZ-104), có kèm Infrastructure as Code

## Kỹ năng thể hiện

`Active Directory` `Group Policy` `DNS` `Entra ID` `Entra Connect` `Exchange Online` `SharePoint` `Teams` `Conditional Access` `Microsoft Intune` `Microsoft Defender` `Microsoft Purview` `Azure Virtual Network` `Hub-Spoke Architecture` `Azure Bastion` `NSG/ASG` `Azure Arc` `Azure Monitor` `Log Analytics (KQL)` `Azure Backup` `Azure Update Manager` `Bicep (IaC)` `Power Automate` `Copilot Studio`

## Cách xem project

Mỗi thư mục module có README riêng mô tả mục tiêu, các bước triển khai chính, và dẫn link tới ảnh chụp bằng chứng trong `screenshots/`. Module 05 có thêm `infra/` chứa code Bicep để tái triển khai hạ tầng.
