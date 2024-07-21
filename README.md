# NewsApp
NewsApp là một ứng dụng di động được xây dựng theo mô hình MVVM, cho phép người dùng tìm kiếm và đọc các bài báo từ nhiều nguồn khác nhau. Ứng dụng bao gồm hai màn hình chính: FiltersViewController và NewsViewController.

## Mô tả
### FiltersViewController

<img src="https://github.com/user-attachments/assets/50100b92-3f8f-4c8b-93c0-d23535bbfd34" alt="Simulator Screenshot - iPhone 15 Pro - 2024-07-22 at 00 34 41" width="350" height="800">
<br>
<br>
FiltersViewController là màn hình đầu tiên mà người dùng sẽ thấy khi mở ứng dụng. Màn hình này cho phép người dùng chọn các tùy chọn sau:
- Từ khoá
- Danh mục
- Quốc gia
- Ngôn ngữ
- Ngày
- Sắp xếp
  
Khi người dùng đã chọn xong các tùy chọn và nhấn vào nút "Search", ứng dụng sẽ chuyển sang màn hình NewsViewController.

### NewsViewController

<img src="https://github.com/user-attachments/assets/a33db7b6-36d6-411f-a1f3-47a601f63f0c" alt="Simulator Screenshot - iPhone 15 Pro - 2024-07-22 at 00 34 54" width="350" height="800">
<br>
<br>
NewsViewController hiển thị danh sách các bài báo thỏa mãn các điều kiện đã đặt ra ở FiltersViewController. Màn hình này sử dụng UITableView để hiển thị danh sách bài báo, cho phép người dùng dễ dàng duyệt qua các bài viết.

## Yêu cầu kỹ thuật
Dưới đây là các yêu cầu kỹ thuật đã được hoàn thành trong dự án:
- Mô hình MVVM.
- Hiển thị danh sách bài báo: NewsViewController sử dụng UITableView để hiển thị danh sách các bài báo.
- Multithreading: Sử dụng async/await.
- Request API: URLSession để request API và Codable protocol cho JSON parser.

## Tài liệu API
API mà dự án sử dụng có thể xem tại: https://mediastack.com/documentation
